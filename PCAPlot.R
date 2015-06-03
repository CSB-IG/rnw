#!/usr/bin/env Rscript
#
#
# try $ ./PCAPlot.R -h for help
#
#

suppressPackageStartupMessages(library(argparse))
suppressPackageStartupMessages(library(ggbiplot))

parser <- ArgumentParser(description="Plot PCA from a matrix file.")
parser$add_argument("--matrix", required=TRUE, help="matrix file")
parser$add_argument("--pdf", required=TRUE, help="path to PDF output")
args   <- parser$parse_args()


pcaexprmat<-function(M){
    T.M<-t(M)
    colnames(T.M)<-rownames(M)
    T.M.log<-log(T.M)
    T.M.pca<-prcomp(T.M, center=TRUE, scale.=TRUE)
                                        #plot(T.M.pca, type = "l")

    summary(T.M.pca)
    return(T.M.pca)
}


plotpcagroups <-function (T.M.pca, outpdf) {
    pdf(file=outpdf)    
    g <- ggbiplot(T.M.pca, obs.scale = 1, var.scale = 1, var.axes=FALSE, ellipse = TRUE, circle = TRUE)
    g <- g + scale_color_discrete(name = '')
    g <- g + theme(legend.direction = 'horizontal',
                   legend.position = 'top')
    print(g)
    dev.off()
}






M = read.table(args$matrix, sep=",", header=TRUE, row.names=1)

plotpcagroups( pcaexprmat(M), args$pdf )
