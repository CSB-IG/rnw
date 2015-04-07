#This function must recieve a Vector character "VC" and a list "L" of two lists
#"L[1] and L[2]" where each line connects respectively a sample with his experiment.
#The output, is a list sorted in the same order as VC and each row connects
#the sample with his experiment, and assign a color to each experiment.
# IMPORTAT: The names in VC and L[,2] must match EXACTLY.
samplesByExpAndColor<-function(VC=vector,L){
  ExpOrd<-matrix(rep(0,3*length(VC)),length(VC),3)
        L[,1]<-as.vector(L[,1])
        L[,2]<-as.vector(L[,2])
  for(i in 1:length(VC)){
    for(j in 1:length(L[,1])){
        if(VC[i]==L[j,2]){
                ExpOrd[i,1]<-L[j,1]
                ExpOrd[i,2]<-L[j,2]
        }
    }
  }
  Coloreado<-groupsByColors(ExpOrd[,1])  
  ExpOrd[,3]<-Coloreado[,2]
  #ExpOrd[,4]<-Coloreado[,1]
  return(ExpOrd)
}

groupsByColors<-function(V,mode="character"){
  colorEs<-vector(mode="character",length=0)
  LevelsOfV<-theLevels(V)
  COLORES<-GiveMeTheColors(LevelsOfV)
  PutTheColors<-substituteByColors(V,LevelsOfV,COLORES)
  return(PutTheColors)
}
theLevels<-function(NV){
  LevelsNV<-vector()
  FactorNV<-as.factor(NV)
  LevelsNV<-attributes(FactorNV)$levels
  return(LevelsNV)
}
GiveMeTheColors<-function(LevelsNV){
  Colorines<-rainbow(length(LevelsNV))
  return(Colorines)
}
substituteByColors <-function(ForSub,LevelsNV,COLORES){
  Substituted<-matrix(rep(0,length(ForSub)*2),length(ForSub),2)
  Substituted[,1]<-ForSub
  for(i in 1:length(LevelsNV)){
    for(j in 1:length(ForSub)){
      if(LevelsNV[i]==ForSub[j]){
        Substituted[j,2]<-(COLORES[i])
      }
    }
  }
return(Substituted)
}
