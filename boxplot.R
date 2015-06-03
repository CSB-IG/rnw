#!/usr/bin/env Rscript
#
#
# try $ ./PCAPlot.R -h for help
#
#

suppressPackageStartupMessages(library(argparse))

parser <- ArgumentParser(description="Box Plot from a matrix file.")
parser$add_argument("--matrix", required=TRUE, help="matrix file")
parser$add_argument("--pdf", required=TRUE, help="path to PDF output")
args   <- parser$parse_args()

matrix = read.table(args$matrix, sep=",", header=TRUE, row.names=1)

pdf(file=args$pdf)    
boxplot(matrix)
dev.off()
