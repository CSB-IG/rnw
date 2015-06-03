#!/usr/bin/env Rscript
#
#
# try $ ./PCAPlot.R -h for help
#
#

suppressPackageStartupMessages(library(argparse))
library(devtools)
install_github("ggbiplot", "vqv")
library(ggbiplot)

parser <- ArgumentParser(description="Plot PCA")
parser$add_argument("--matrix", required=TRUE, help="normalized expression matrix output")
parser$add_argument("--pdf", required=TRUE, help="path to PDF output")
args   <- parser$parse_args()


pcaexprmat<-function(M){
        #An expression matrix as input.
        T.M<-t(M)
        #Se transpone para que los pacientes queden como rownames y se integren con los grupos definidos sobre ellossean grupo
        colnames(T.M)<-rownames(M)
        # Se evita que los colnames de la nueva matrix queden vacios (de lo contrario ggplots dara problemas)
        T.M.log<-log(T.M)
        T.M.pca<-prcomp(T.M,center=TRUE,scale.=TRUE)
        summary(T.M.pca)
        plot(T.M.pca, type = "l")
        return(T.M.pca)
}


plotpcagroups <-function (T.M.pca , SPECIES){
              g <- ggbiplot(T.M.pca, obs.scale = 1, var.scale = 1, var.axes=FALSE ,groups = SPECIES, ellipse = TRUE, circle = TRUE)
              g <- g + scale_color_discrete(name = '')
              g <- g + theme(legend.direction = 'horizontal',
               legend.position = 'top')
               pdf(file="PlotT.M.pca.pdf")
               print(g)
               dev.off()
}


M = read.table(args$matrix)
plotpcagroups( pcaexprmat(M) )