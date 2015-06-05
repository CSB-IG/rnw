## Installing dependencies for: "argparse", "devtools", "ggbiplot" (GitHub), 
## "vqv"; BioConductor: "ctc", "heatmap.plus", "impute", "genefu", "limma",
## "affy", "annotate", "hugene10sttranscriptcluster.db"

###############################################################################
### Specifying sources
###############################################################################

source("http://bioconductor.org/biocLite.R")

###############################################################################
### Installing and/or loading required packages 
###############################################################################

### From CRAN ###

if (!require("argparse")) {
  install.packages("argparse", dependencies = TRUE)
  library(argparse)
}
if (!require("devtools")) {
  install.packages("devtools", dependencies = TRUE)
  library(devtools)
}

### From Github (requires devtools) ###

if (!require("ggbiplot")) {
  install_github("vqv/ggbiplot", dependencies = TRUE)
  library(ggbiplot)
}

# if (!require("vqv")) {
#   install_github("vqv", username = "vqv" , dependencies = TRUE)
#   library(vqv)
# } ## Is this a package??? Not found!!! ######################################

### From BioConductor ###

if (!require("ctc")) {
  biocLite("ctc", ask =FALSE)
  library(ctc)
}
if (!require("heatmap.plus")) {
  biocLite("heatmap.plus", ask =FALSE)
  library(heatmap.plus)
}
if (!require("impute")) {
  biocLite("impute", ask =FALSE)
  library(impute)
}
if (!require("genefu")) {
  biocLite("genefu", ask =FALSE)
  library(genefu)
}
if (!require("limma")) {
  biocLite("limma", ask = FALSE)
  library(limma)
}
if (!require("affy")) {
  biocLite("affy", ask = FALSE)
  library(affy)
}
if (!require("annotate")) {
  biocLite("annotate", ask = FALSE)
  library(annotate)
}
if (!require("hugene10sttranscriptcluster.db")) {
  biocLite("hugene10sttranscriptcluster.db", ask = FALSE)
  library(hugene10sttranscriptcluster.db)
}
