#!/usr/bin/env Rscript
#
#
# try $ ./frma_normalizer.R -h for help
#
#

suppressPackageStartupMessages(library(argparse))
suppressPackageStartupMessages(library(affy))
suppressPackageStartupMessages(library(limma))
suppressPackageStartupMessages(library(frma))

parser <- ArgumentParser(description="Normalize all CEL files in a same folder with frma")
parser$add_argument("--celfolder", nargs="+", help="CEL files directory to normalize")
parser$add_argument("--bgcorrect", default="rma", help="type of background correction to perform: either none or rma")
parser$add_argument("--normalize", default="quantile", help="type of normalization to perform: either none or quantile")
parser$add_argument("--summarize", default="robust_weighted_average", help="type of summarization to perform: one of median_polish, average, median, weighted_average, robust_weighted_average, random_effect")
parser$add_argument("--matrix", required=TRUE, help="normalized expression matrix output")
args <- parser$parse_args()

# read 'em
affybatch <- ReadAffy(celfile.path=args$celfolder)

# normalize 'em

# oldw <- getOption("warn")
# options(warn = -1) # silencing unnecessary warning message

frmaData <- frma(affybatch, background=args$bgcorrect,
                            normalize=args$normalize,
                            summarize=args$summarize)

# options(warn = oldw) # restoring warning messages

eset<-exprs(frmaData)
# write 'em!
write.table(eset, file=args$matrix, , quote = F, row.names = TRUE, col.names = TRUE, sep = "\t")



# report 'em
report = file.path(dirname(args$matrix), paste(sub("^([^.]*).*", "\\1", basename(args$matrix)),".pdf",sep=""))
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