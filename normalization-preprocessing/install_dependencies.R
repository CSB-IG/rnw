## Installing packages and dependencies for preprocessing and normalization submodule:
#   "argparse"
#   "affy"
#   "limma"
#   "frma"
#   "sva"
#   "lme4"
#   "gProfileR"

### Specifying sources
source("http://bioconductor.org/biocLite.R")

###############################################################################
### Installing and/or loading required packages 
###############################################################################

### From CRAN ###

if (!require("argparse")) {
  install.packages("argparse", dependencies = TRUE)
}
if (!require("lme4")) {
  install.packages("lme4", dependencies = TRUE)
}

if (!require("gProfileR")) {
  install.packages("gProfileR", dependencies = TRUE)
}

### From BioConductor ###

if (!require("affy")) {
  biocLite("affy", ask =FALSE)
}
if (!require("limma")) {
  biocLite("limma", ask =FALSE)
}
if (!require("frma")) {
  biocLite("frma", ask =FALSE)
}
if (!require("sva")) {
  biocLite("sva", ask =FALSE)
}
if (!require("limma")) {
  biocLite("limma", ask = FALSE)
}
if (!require("affy")) {
  biocLite("affy", ask = FALSE)
}
if (!require("annotate")) {
  biocLite("annotate", ask = FALSE)
}