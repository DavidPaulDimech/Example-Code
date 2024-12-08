library(mvtnorm)

fBMpath = scan(file = "C:/Users/dpdim/Desktop/Thesis Progs/path.txt", what = numeric(), sep = ",")
fBMpath<-fBMpath[1:length(fBMpath)-1]
alpha=20
beta=20
k=2
theta=2
dimension=length(fBMpath)

R1<-matrix(c(1:dimension),dimension,dimension) 
R2<-t(R1)
R3<-abs(R1-R2)

createR<-function(y){
  H<-y[1]
  s<-y[2]
  return((s*0.5*(R1^(2*H)+R2^(2*H)-R3^(2*H))))
}

targetDist <- function(x){
  n<-100
  z<-50
  if(x<=0  || x>=1){
    return(0)
  }
  else{
    return(exp(-3*x)*(x^n)*((1-x)^(n-z)))
  }
}

etaSeq <- function(x){
  return(1/x)  
}


