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
parser$add_argument("--matrix", required=TRUE, help="normalized expression matrix")
parser$add_argument("cel", nargs="+", help="CEL files to normalize")
args   <- parser$parse_args()


suppressPackageStartupMessages(library(limma,gplots))

# read 'em
affybatch <- read.affybatch(filenames=args$cel)

# normalize 'em
eset <- expresso(affybatch, bgcorrect.method=args$bgcorrect,
                            normalize.method=args$normalize,
                            pmcorrect.method="pmonly",
                            summary.method="medianpolish")

# write 'em!
write.csv(eset, file=args$matrix)
