#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(argparse))
suppressPackageStartupMessages(library(affy))
suppressPackageStartupMessages(library(limma,gplots))

#library(GO.db)
#library(annotate)


parser <- ArgumentParser(description="Normalize CEL files of a same batch.")
parser$add_argument("--matrix", required=TRUE, help="normalized expression matrix")
parser$add_argument("cel", nargs="+", help="CEL files to normalize")
args   <- parser$parse_args()


# read 'em
affybatch <- read.affybatch(filenames=args$cel)

# normalize 'em
eset <- expresso(affybatch, bgcorrect.method="none", normalize.method="quantiles", pmcorrect.method="pmonly", summary.method="medianpolish")

# write 'em!
write.csv(eset, file=args$matrix)
