library(MASS)
adaptMCMC2 <- function(target,mean,eta,covariance,initalValue,acceptanceRate,burnInPeriod,chainSize) { # 
  dim<-length(mean)
  chain<-matrix(0, nrow = dim, ncol = chainSize+burnInPeriod)
  chain[1:dim,1]<-initalValue
  for (i in 2:(chainSize+burnInPeriod)){
    U = mvrnorm(n=1,mu=mean,Sigma=diag(dim))
    newX=chain[1:dim,i-1]+covariance%*%U
    print(newX)
    alpha=min(c(1,(target(newX)/target(chain[1:dim,i-1]))))
    if(runif(1)<alpha){
      chain[1:dim,i]<-newX          
    }
    else{
      chain[1:dim,i]<-chain[1:dim,i-1]
    }
    term1= diag(dim)+eta(i)*(alpha-acceptanceRate)*((U%*%t(U))/(U%*%U)[1])
    term2=covariance %*% term1
    finalTerm = term2%*%t(covariance)
    covariance=t(chol(finalTerm))
  }
  return(chain[1:dim,(burnInPeriod+1):(chainSize+burnInPeriod)])
}
# target = target dist
# mean = mean of U
# eta = decreasing step seq
# covariance = covariance of U
# initialValue = initial value of H
# acceptance rate = mean acceptance rate
