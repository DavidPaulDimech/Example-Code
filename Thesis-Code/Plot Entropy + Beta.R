#define range
p = seq(0, 1, length=10000)

plot(p, dbeta(p, 40,62),type="l",xlab="p*",ylab="Density",ylim=c(0,10),lwd=2,cex=1.05)
lines(p, dbeta(p, 47.14,72.86),type="l",col="blue",lwd=2)
lines(p, dbeta(p, 50.08,69.92),type="l",col="red",lwd=2)

legend("topright", legend = c("Beta(40,62)", "Beta(47.14,72.86)","Beta(50.08,69.92)","MEP(1.28,39,100)","MEP(-0.73,39,100)")
       ,lwd = 3, col = c("black", "blue","red","deepskyblue4","orangered4")
       ,y.intersp=0.2,x.intersp=0.2,cex=1, lty = c(1, 1, 1, 1),box.lwd=0.1)

legend("topright", legend = c("Beta(3911,6091)", "Beta(3918,6102)","Beta(3921,6099)")
       ,lwd = 3, col = c("black", "blue","red")
       ,y.intersp=0.2,x.intersp=0.2,cex=1, lty = c(1, 1, 1),box.lwd=0.1)



z=39
nMinusz=61
B1=1.2755097940488722
B2=-0.7277687920107496

#Constant

f<-function(x) {(x^z)*((1-x)^nMinusz)*exp(-B1*x)}
constantOfIntegration=integrate(f, lower = 0, upper = 1)$value

f2<-function(x) {((x^z)*(1-x)^nMinusz*exp(-B1*x))/(constantOfIntegration)}
lines(p, f2(p), type='l',col="deepskyblue4",lwd=2)


f<-function(x) {(x^z)*((1-x)^nMinusz)*exp(-B2*x)}
constantOfIntegration=integrate(f, lower = 0, upper = 1)$value

f2<-function(x) {((x^z)*(1-x)^nMinusz*exp(-B2*x))/(constantOfIntegration)}
lines(p, f2(p), type='l',col="orangered4",lwd=2)

B=-0.7277687920107496

f<-function(x) {(x^z)*((1-x)^nMinusz)*exp(-B*x)}
constantOfIntegration=integrate(f, lower = 0, upper = 1)$value

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
