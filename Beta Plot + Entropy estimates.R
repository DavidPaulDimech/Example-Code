#define range
p = seq(0, 1, length=10000)


plot(p, dbeta(p, 55, 45), type='l')



z=55
nMinusz=45
B=-0.7277687920107496

#Constant
f<-function(x) {(x^z)*(1-x)^nMinusz*exp(-B*x)}
constantOfIntegration=integrate(f, lower = 0, upper = 1)$value

f2<-function(x) {((x^z)*(1-x)^nMinusz*exp(-B*x))/(constantOfIntegration)}
plot(p, f2(p), type='l',col="blue")



#Expectation
fExp<-function(x) {x*((x^z)*(1-x)^nMinusz*exp(-B*x))/(constantOfIntegration)}
expValue=integrate(fExp, lower = 0, upper = 1)$value
expValue
#Variance

#Variance
fVar<-function(x) {x*x*((x^z)*(1-x)^nMinusz*exp(-B*x))/(constantOfIntegration)}
valueHolder=integrate(fVar, lower = 0, upper = 1)$value
variance = valueHolder-expValue^2
variance

print(c("Mean is ", expValue))
print(c("Variance is ", variance))