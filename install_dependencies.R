## Installing dependencies for: "argparse", "devtools", "ggbiplot" (GitHub), 
## "vqv"; BioConductor: "ctc", "heatmap.plus", "impute", "genefu", "limma",
## "affy", "annotate", "hugene10sttranscriptcluster.db"

###############################################################################
### Specifying sources
###############################################################################

source ()
source ()
source ()

###############################################################################
### Installing and/or loading required packages 
###############################################################################

### PCA ###

if (!require("argparse")) {
  install.packages("argparse", dependencies = TRUE)
  library(argparse)
}
if (!require("devtools")) {
  install.packages("devtools", dependencies = TRUE)
  library(devtools)
}
if (!require("ggbiplot")) {
  install.packages("ggbiplot", dependencies = TRUE)
  library(ggbiplot)
}
if (!require("vqv")) {
  install.packages("vqv", dependencies = TRUE)
  library(vqv)
}

### With BiConductor ###

if (!require("ctc")) {
  install.packages("ctc", dependencies = TRUE)
  library(ctc)
}
if (!require("heatmap.plus")) {
  install.packages("heatmap.plus", dependencies = TRUE)
  library(heatmap.plus)
}
if (!require("impute")) {
  install.packages("impute", dependencies = TRUE)
  library(impute)
}
if (!require("genefu")) {
  install.packages("genefu", dependencies = TRUE)
  library(genefu)
}
if (!require("limma")) {
  install.packages("limma", dependencies = TRUE)
  library(limma)
}
if (!require("affy")) {
  install.packages("affy", dependencies = TRUE)
  library(affy)
}
if (!require("annotate")) {
  install.packages("annotate", dependencies = TRUE)
  library(annotate)
}
if (!require("hugene10sttranscriptcluster.db")) {
  install.packages("hugene10sttranscriptcluster.db", dependencies = TRUE)
  library(hugene10sttranscriptcluster.db)
}
