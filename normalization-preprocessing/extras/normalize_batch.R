#!/usr/bin/env Rscript
#
#
# try $ ./normalize_batch.R -h for help
#
#

suppressPackageStartupMessages(library(argparse))
suppressPackageStartupMessages(library(affy))

parser <- ArgumentParser(description="Normalize CEL files of a same batch.")
parser$add_argument("--bgcorrect", default="none",      choices=bgcorrect.methods(), help="method for background noise correction")
parser$add_argument("--normalize", default="quantiles", choices=normalize.AffyBatch.methods(), help="normalizing method")
parser$add_argument("--matrix", required=TRUE, help="normalized expression matrix output")
parser$add_argument("cel", nargs="+", help="CEL files to normalize")
args   <- parser$parse_args()


suppressPackageStartupMessages(library(limma,gplots))

# read 'em
affybatch <- read.affybatch(filenames=args$cel)

# normalize 'em
eset.quantiles <- expresso(affybatch, bgcorrect.method=args$bgcorrect,
                            normalize.method=args$normalize,
                            pmcorrect.method="pmonly",
                            summary.method="medianpolish")
eset<-exprs(eset.quantiles)
# write 'em!
write.csv(eset, file=args$matrix)

# report 'em
report = file.path(dirname(args$matrix), paste(basename(args$matrix),".pdf",sep=""))
pdf(file=report,width=7,height=5)
N=length(affybatch@phenoData@data$sample)
pm.mm=0
for (i in 1:N) {pm.mm[i] = mean(mm(affybatch[,i])>pm(affybatch[,i]))}
mycolors = rep(c("blue","red","green", "magenta"), each = 2)
hist(affybatch, col=mycolors, main="Raw data distribution")
boxplot(affybatch,col=mycolors, main="Raw data distribution")
plot(100*pm.mm, type='h', main='Percent of MMs > PMs', ylab="%",xlab="Microarrays", ylim=c(0,50), col="red", lwd=5 )
grid(nx = NULL, ny = 6, col = "blue", lty = "dotted",lwd = par("lwd"), equilogs = TRUE)
mycolors = rep(c("blue","red","green", "magenta"), each = 2)
plotDensity(eset, col=mycolors, main="Data After normalization")
boxplot(eset,col=mycolors, main="Data After normalization")
dev.off()