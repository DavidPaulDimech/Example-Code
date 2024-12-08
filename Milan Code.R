# Milan Data set
glmnet_cv_aicc <- function(fit, lambda = 'lambda.1se'){
  whlm <- which(fit$lambda == fit[[lambda]])
  with(fit$glmnet.fit,
       {
         tLL <- nulldev - nulldev * (1 - dev.ratio)[whlm]
         k <- df[whlm]
         n <- nobs
         return(list('AICc' = - tLL + 2 * k + 2 * k * (k + 1) / (n - k - 1),
                     'BIC' = log(n) * k - tLL))
       })
}

BICAICglm=function(fit){
  #tLL <- fit$null.deviance - deviance(fit)  
  tLL <- -deviance(fit) # 2*log-likelihood
  k <- dim(model.matrix(fit))[2]
  n <- nobs(fit)
  AICc <- -tLL+2*k+2*k*(k+1)/(n-k-1)
  AIC_ <- -tLL+2*k
  
  BIC<-log(n)*k - tLL
  res=c(AIC_, BIC, AICc)
  names(res)=c("AIC", "BIC", "AICc")
  return(res)
}


# Packages ----------------------------------------------------------------
library(stringr) #Counting instances in string
library(glmnet) #Ridge Regression Package
library(ModelMatrixModel) #Model Matrices
library(arm)

# Declaring Variables ------------------------------------------------------
data=read.csv(file.choose(),header=TRUE)
dataNoNulls <- data[complete.cases(data), ]
dependentVariablesOrId<-4
nonFactorsIndex<-c(1,2,3,4,5,6,12,21,22,23,25,26,28) #Columns which aren't factors
admissable<-""


# Data Manipulation -------------------------------------------------------
for(i in 1:ncol(data)) {  #Assigning each column to be an X no nulls data
  if(i<=dependentVariablesOrId+1){
    nam <- paste("y", i-1, sep = "") #Dependent Variables are named with y
  }
  else{
    nam <- paste("x", i-dependentVariablesOrId-1, sep = "")  #Independent Variables are named with x
    admissable<-paste(admissable,nam,sep="+")
  }
 
  if(i %in% nonFactorsIndex){ #Declaring yi and xi to be factors or numeric as necessary
    assign(nam, (dataNoNulls[1:nrow(dataNoNulls),i]))    
  }
  else{
    assign(nam, as.factor(dataNoNulls[1:nrow(dataNoNulls),i]))
  }
}
# Models ------------------------------------------------------------------ 


dataFrame<-data.frame(x2,x3,x4,x5,x6,x8,x9,x10,x11,x12,x13,x14,x15,x19,x22)
x<-model.matrix(~x2+x3+x4+x5+x6+x8+x9+x10+x11+x12+x13+x14+x15+x18+x19+x20+x21+x22 , data=dataFrame)

# Ridge/Lasso
cv.out <- cv.glmnet(x,y1,alpha=1,family="gaussian",type.measure = "mse")
lambdaMin<-cv.out$lambda.min

fit <- cv.out$glmnet.fit
y_predicted <- predict(fit, s = lambdaMin, newx = x)
coef(cv.out, s=lambdaMin)

sst <- sum((y1 - mean(y1))^2)
sse <- sum((y_predicted - y1)^2)
rsq <- 1 - sse / sst
rsq

print(glmnet_cv_aicc(cv.out, 'lambda.min'))

# Standard GLM
glmModel <-glm.fit(x,y1,family =Gamma(link = "inverse"))
glmModel$aic

sst <- sum((y1 - mean(y1))^2)
sse <- sum((glmModel$fitted.values - y1)^2)
rsq <- 1 - sse / sst
rsq

# Adaptive Lasso
g = 1
modelr <- cv.glmnet(x, y1, alpha = 0)
lambdaMin<-modelr$lambda.min
coefr <- as.matrix(coef(modelr, s = modelr$lambda.min))
w.r <- 1/(abs(coefr[-1,]))^g
alasso <- cv.glmnet(x, y1, alpha=1, penalty.factor = w.r)
lambdaMin<-alasso$lambda.min


fit <- alasso$glmnet.fit
y_predicted <- predict(fit, s = lambdaMin, newx = x)
coef(alasso, s=lambdaMin)

sst <- sum((y1 - mean(y1))^2)
sse <- sum((y_predicted - y1)^2)
rsq <- 1 - sse / sst
rsq

