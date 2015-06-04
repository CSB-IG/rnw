#!/usr/bin/env Rscript
#
#
# try $ ./PCAPlot.R -h for help
#
#
#This Script takes a expression matrix as input, and returns a principal component analysis graphic

suppressPackageStartupMessages(library(argparse))
suppressPackageStartupMessages(library(ggbiplot))

parser <- ArgumentParser(description="Plot PCA from a matrix file.")
parser$add_argument("--matrix", required=TRUE, help="matrix file")
parser$add_argument("--pdf", required=TRUE, help="path to PDF output")
parser$add_argument("--groups_list", required=TRUE, help="csv file that indicates how many groups are in your data")
args   <- parser$parse_args()

#Suggestion: Add option to write out the covariance matrix as a CSV file --GDJ 

#This function makes the Principal Component Analysis
pcaexprmat<-function(M){
    T.M<-t(M)
    colnames(T.M)<-rownames(M)
    T.M.log<-log(T.M)
    T.M.pca<-prcomp(T.M, center=TRUE, scale.=TRUE)
                                        #plot(T.M.pca, type = "l")
    #summary(T.M.pca)
    return(T.M.pca)
}
#Make the plot of PCA
plotpcagroups <-function (T.M.pca, outpdf) {
    pdf(file=outpdf)    
    g <- ggbiplot(T.M.pca, obs.scale = 1, var.scale = 1, var.axes=FALSE, groups=mygroups, ellipse = TRUE, circle = TRUE)
    g <- g + scale_color_discrete(name = '')
    g <- g + theme(legend.direction = 'horizontal',
                   legend.position = 'top')
    print(g)
    dev.off()
}
#Read the expression matrix
M = read.table(args$matrix, sep=",", header=TRUE, row.names=1)
#Read the vector which correlates the position of each column to its gruop
mygroups<-read.table(args$groups_list,header=FALSE)
mygroups<-mygroups$V1
#Call to the functions
plotpcagroups( pcaexprmat(M), args$pdf )
