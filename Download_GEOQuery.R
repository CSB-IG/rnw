###   Script made Wed Nov  4 19:52:46 CST 2015
###   R version 3.2.0 (2015-04-16) -- "Full of Ingredients"
###   Platform: x86_64-unknown-linux-gnu (64-bit)
###   GEOquery_2.34.0     Biobase_2.28.0      BiocGenerics_0.14.0

#install GEOquery
source("http://bioconductor.org/biocLite.R")
biocLite("GEOquery")
library(GEOquery)

############################################################################  
# A) If you have the GSM vector try to Download the .CEL files through:  ###
############################################################################

# You need your own GSM vector, or for this time you can use the following:
############### Example GSM vector #################
MyGSMList = c("GSM272923","GSM272924","GSM272925")##
####################################################

sapply(MyGSMList,function(x){ getGEOSuppFiles(x)})




###################################################################
# B) If you only have a GSE's list use the next chunk of code #####
###################################################################

#This couple of functions download the .CEl.gz files asociated with your GSEs 
# and also retrieves you  a vector with the GSM names.

GSMnamesFromVecGSEnames<- function(vecGSEnames){
  #This function recieves a vector of GSEnames
  # Build up  a list with equal length to the vector of GSEnames 
  GSEObjects<-list(length=length(vecGSEnames))
  #Fill thath list with GSEObjects
  for(i in 1:length(vecGSEnames)){
    GSEObjects[i]<-getGEO(vecGSEnames[i],GSEMatrix=FALSE)
    print("We have theGSE Object"); print(i)
  }
    #Call to the function to GEt a vector of GSM names of each GSE
    AllGSMnames<-NamesVectorGSMFromGSE(GSEObjects)
    #Call to a function to download the CEL files, from the previous GSMnames vector.
    DownCELFromThisGSMVec(AllGSMnames)
    #Return the GSMnames vector
  return(AllGSMnames)  
}
  # This function recieves a List of GSEObjects and return all GSMnames in a Vector 
NamesVectorGSMFromGSE <-function(ThisGSEObject){
 #Build up a vector of length zero
  vecpartialnames<-vector(length=0)
  #Fill the previous object with the GSM names.
    for (i in 1:length(ThisGSEObject)){
    vecpartialnames<-c(vecpartialnames,names(GSMList(ThisGSEObject[[i]])))
    }
  return(vecpartialnames)
}  

# Example of use
MyGSE=c("GSE2327","GSE2298")
GSMList_of_MyGSE<-GSMnamesFromVecGSEnames(MyGSE)
