library(affy) 
library(frma)
library(sva)
library(annotate)
library(hgu133plus2.db)
library(limma)



# Set working directory in the CEL files folder
setwd("/mnt/d/rmejia/Depurate_719RaulDB")
Data = ReadAffy()


setwd("/home/hachepunto/rauldb")

N=length(Data@phenoData@data$sample)
pm.mm=0
for (i in 1:N) {pm.mm[i] = mean(mm(Data[,i])>pm(Data[,i]))}
mycolors = rep(c("blue","red","green", "magenta"), each = 2)

# Control plot for raw data

pdf("DataGraphs.pdf",width=7,height=5)
hist(Data, col=mycolors, main="Raw data distribution")
boxplot(Data,col=mycolors, main="Raw data distribution")
plot(100*pm.mm, type='h', main='Percent of MMs > PMs', ylab="%",xlab="Microarrays", ylim=c(0,50), col="red", lwd=5 )
grid(nx = NULL, ny = 6, col = "blue", lty = "dotted",lwd = par("lwd"), equilogs = TRUE)
dev.off()

# Frozen Robust Multi-Array summarization/normalization
frmaData <- frma(Data, summarize="robust_weighted_average") #tardado

# Extracting the expresion matrix
edata<-exprs(frmaData)

# Control plot for summarized data

pdf("frmaNormalized.pdf",width=7,height=5)
mycolors = rep(c("blue","red","green", "magenta"), each = 2)
plotDensity(edata, col=mycolors, main="frma normalization")
boxplot(edata,col=mycolors, main="Normalized data distribution")
dev.off()

# batch

pheno <- read.table("rauldb_batch.txt", header = TRUE, sep = "\t", row.names=1)

options("contrasts")
modcombat = model.matrix(~ outcome, pheno, contrasts = list(outcome = "contr.sum"))

batch <- pheno$batch

combat_edata = ComBat(dat=edata, batch=batch, mod=modcombat)

pdf("ComBat_Normalized.pdf",width=7,height=5)
mycolors = rep(c("blue","red","green", "magenta"), each = 2)
plotDensity(combat_edata, col=mycolors, main="ComBat normalization")
boxplot(combat_edata,col=mycolors, main="Normalized data distribution")
dev.off()


# Design and contingence matrix
design = matrix(rep(0,1438), nrow=719)
colnames(design) = c('tumor','sano')
rownames(design) = colnames(combat_edata)
design[which(pheno$outcome == "tumor"),1]=1
design[which(pheno$outcome == "healthy"),2]=1
cont.matrix = makeContrasts('tumor - sano', levels=design)

fit = lmFit(combat_edata, design)
fit2 = contrasts.fit(fit, cont.matrix)
fit2 = eBayes(fit2)

topTable(fit2, coef=1, adjust='fdr')

statistics <- topTable(fit2, coef=1, adjust='fdr', n = length(row.names(combat_edata)), sort = "none")

summary(statistics[,6])

# Control plot for log Fold Change

pdf(file="combat_logFC_statisitics.pdf")
boxplot(statistics[,1])
dev.off()

# Control plot for B statistic

pdf(file="combat__B_statisitics.pdf")
boxplot(statistics[,6])
dev.off()

affys<-rownames(combat_edata)

write.table(affys, file="affysIDs.txt", quote = F, row.names = F, col.names = F)

genesymbols<-getSYMBOL(as.character(affys), "hgu133plus2.db")
write.table(genesymbols, file="hgu133plus2DB.txt", quote = F, row.names = TRUE, col.names = F)

# Read my oun annotation of the chip 
my_annotation <- read.table(file="myannotation_plus2.txt", header = TRUE, row.names=1,colClasses = "character")

precolaps_combat <- cbind(my_annotation, statistics[,6],combat_edata)
colnames(precolaps_combat)[2] <- c("b")
write.table(precolaps_combat, file="rauldb_matrix_precolaps.txt", quote = FALSE, sep = "\t", row.names = FALSE)



                 ########################################################################################
                 #											#
                 #                          		 External processing		                                                                                   		     #
                 #											                                                                                                           #
                 #	Python script collapser: "microarray_colapser.py"		                                                       		     #
                 #	input:  rauldb_matrix_precolaps.txt	                       			#
                 #	output: rauldb_matrix_precolaps_collapsed.txt					#
                 #	$ cut --complement -f2 rauldb_matrix_precolaps_colapsed.txt > exp_collapsed.txt #		                           #
                 #											#
                 ########################################################################################

eset <- read.table("exp_collapsed.txt", header=TRUE, sep="\t", row.names=1)

tumor <- which(pheno$outcome == "tumor")
healthy <- which(pheno$outcome == "healthy")

tumor_eset <- eset[,tumor]
healthy_eset <- eset[,healthy]
write.table(eset[,tumor], file="tumor_exp_matrix.txt", quote = FALSE, sep = "\t", row.names = TRUE)

save(eset, tumor, healthy, file="exp_set.RData")
save(tumor_eset, tumor, healthy, file="tumor_exp_set.RData")

############# DPI ####################

# list of .adj to square matrix

library(plyr)
library(minet)
library(igraph)


# set working dir as the dir where the .adj are
# if other dir is used: filenames <- list.files("other_directory", pattern="*.adj")
setwd("tumor_rauldb_1exp-8")
adjs <- sort(list.files(pattern="*1e-08.adj"))
# length must be equal to genes
length(adjs)

# reads just the last line from file take values as characters
# converts to matrix and assign first col as rownames 

adjtosqmtx <- function(g){
  a <- scan(file = g, skip = 0, what = "")
  m <- matrix(unlist(a[-(1)]), ncol = 2, byrow = T)
  rownames(m) <- c(m[,1])
  m <- t(m[,2])
  m
}


# joins all adjs in square matrix and fill empty spaces with NA
M <- lapply(adjs, adjtosqmtx)
x <- t(rbind.fill.matrix(M))
setwd("/home/hachepunto/rauldb")

# replace all NA for 0
x[is.na(x)] <- 0

# turn character matrix to numeric
class(x) <- "numeric"

# sets colnames as the gene name from adjs name
names <- gsub('.{30}$','', adjs)
colnames(x) <- names

length(names)
length(which(!names %in% rownames(x)))
length(which(rownames(x) %in% names))

page(x[,tf_faltantes]!=0, method="print")

tf_faltantes<-names[which(!names %in% rownames(x))]
faltantes<-rownames(x)[-which(rownames(x) %in% names)]
length(faltantes) + ncol(x)

mabajo <- matrix(rep(0,length(tf_faltantes)*ncol(x)), ncol=ncol(x))
rownames(mabajo)<-tf_faltantes

x2 <- rbind(x,mabajo)

malado<- matrix(rep(0,length(faltantes)*nrow(x2)), ncol=length(faltantes))
colnames(malado)<-faltantes

x3<-cbind(x2,malado)
dim(x3)
# select rownames as colnames and orders them alphabetically
is S

# control: class must be 'matrix'
# matrix must be symmetric
class(x3) <- "numeric"
class(x3)
isSymmetric(x3)

# apply data processing inequality (dpi)
xdpi <- aracne(mim =  x3, eps = 0.2)

dim(xdpi[tfs,])

write.table(xdpi[tfs,], file = "mx_rauldb_p8_dpi0.2.txt", sep = "\t", col.names= T, row.names= T, quote = F )
save(Data,frmaData,edata,pheno,modcombat, batch, combat_edata, design, cont.matrix,statistics,affys, my_annotation,precolaps_combat,eset,tumor,healthy,adjs,adjtosqmtx,M,x,x3,xdpi,file="rauldb.RData")

#save.image("rauldb.RData")

setwd("IPA")

load("../rauldb.RData")
load("../rauldb_MARINa.RData")
load("../subclasificacion/basal_MARINA/basal_rdb_MARINa.RData")

ls()

summary(mrs, mrs=100)$Regulon

eset[unlist(mrs$ledge[summary(mrs, mrs=100)$Regulon]),]

fit = lmFit(eset[unlist(mrs$ledge[summary(mrs, mrs=100)$Regulon]),], design)
fit2 = contrasts.fit(fit, cont.matrix)
fit2 = eBayes(fit2)

top_100statistics <- topTable(fit2, coef=1, adjust='fdr', n = length(row.names(combat_edata)), sort = "none")

write.table(top_100statistics, file="top_100statistics.txt", sep = "\t", quote = F, row.names = T, col.names = T)