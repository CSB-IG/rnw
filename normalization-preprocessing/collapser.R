#!/usr/bin/env Rscript
#
#
# try $ ./pre_collapse.R -h for help
#
#

suppressPackageStartupMessages(library(argparse))
suppressPackageStartupMessages(library(gProfileR))
suppressPackageStartupMessages(library(limma))

parser <- ArgumentParser(description="Collapse the expression matrix by gene symbols with B statistical")
parser$add_argument("--matrix", required=TRUE, help="normalized expression matrix")
parser$add_argument("--phenotype", required=TRUE, help="phenotype data")
parser$add_argument("--collapse", default="B", help="procedure to collapse, B or means")
parser$add_argument("--case", default="case", help="name of cases in the phenotype file")
parser$add_argument("--control", default="control", help="name of controls in the phenotype file")
parser$add_argument("--pathifier", default="no", help="if you need a matrix ready for Run_Pathifier.R, say yes")
args <- parser$parse_args()

# get the data
edata <- as.matrix(read.table(file=args$matrix, header=TRUE, sep="\t", row.names=1))
pheno <- read.table(file=args$phenotype, header = TRUE, sep = "\t", row.names=1)

# annotation
gconvert <- gconvert(query=rownames(edata), target="HGNC", mthreshold=1, filter_na=FALSE)
class(gconvert[,1])<-"integer"
gconvert<- gconvert[sort.list(gconvert[,1]),]

genesymbol <- gconvert[,5]
genesymbol<-ifelse(genesymbol=="N/A", as.vector(rownames(edata)), as.vector(genesymbol))

#genesymbol<-read.table(file="genesymbol.txt", header = TRUE, sep = "\t")
#write.table(genesymbol,file="genesymbol.txt", quote = FALSE, sep = "\t", row.names = FALSE,)

# Design a contingence matrix
design = matrix(rep(0, 2*length(rownames(pheno))), nrow=length(rownames(pheno)))
colnames(design) <- c('case','control')
rownames(design) <- rownames(pheno)
design[which(pheno$outcome == args$case),1]=1
design[which(pheno$outcome == args$control),2]=1

if (args$collapse=="B") {
	###  B collapse  ###
	# make the contrasts matrix
	cont.matrix = makeContrasts('case - control', levels=design)
	# differential expression analisys
	fit = lmFit(edata, design)
	fit2 = contrasts.fit(fit, cont.matrix)
	fit2 = eBayes(fit2)
	statistics <- topTable(fit2, coef=1, adjust='fdr', n = length(row.names(edata)), sort = "none")
	# making the matrix to proced the collapse
	precolaps <- data.frame(genesymbol, statistics[,6],edata)
	colnames(precolaps)[2]<-"B"
	# collapse
	colapsed <- do.call(rbind, lapply(split(precolaps,precolaps$genesymbol),function(chunk) chunk[which.max(chunk$B),]))
	colapsed <- colapsed[,-2]
} else if (args$collapse=="means") {
	###  Media collapse  ###
	precolaps <- data.frame(genesymbol, edata)
	colapsed <- do.call(rbind, lapply(split(precolaps,precolaps[,1]), function(chunk) {colMeans(chunk[,-1])}))
} else {stop("B or means most be selected")}

## Write result
if (args$pathifier=="no") {
	# write
	result = file.path(dirname(args$matrix), paste(sub("^([^.]*).*", "\\1", args$matrix),"_colapsed.txt",sep=""))
	write.table(colapsed, file=result, quote = FALSE, sep = "\t", row.names = FALSE)
} else if (args$pathifier=="yes"){
	# for Pathifier
	NORMALS <- c(3,design[,2])
	pathifier <- rbind(NORMALS,as.matrix(colapsed))
	pathifier[1,1]<-"NORMALS"
	result = file.path(dirname(args$matrix), paste(sub("^([^.]*).*", "\\1", args$matrix),"_pathifier.txt",sep=""))
	write.table(pathifier, file=result, quote = FALSE, sep = "\t", row.names = FALSE)
} else {
	stop("please write yes or no")
}

