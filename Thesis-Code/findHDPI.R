library(HDInterval)
library(EnvStats)


chain = scan(file = "C:/Users/dpdim/Desktop/Thesis Progs/MEDist.txt", what = numeric(), sep = ",")
chain<-chain[1:length(chain)-1]


pvector=chain
Hvector= 1+log2(cos(pi*pvector/2))
#Hvector[Hvector<0] = 1e-5

intervalp=(hdi(pvector, credMass = 0.95))
intervalH=(hdi(Hvector, credMass = 0.95))


pmin<-unname(intervalp[1])
pmax<-unname(intervalp[2])


#Beta
alpha=48256
beta=53410
pVector=rbeta(100000, alpha, beta)
intervalp=(hdi(pVector, credMass = 0.95))
Hvector= 1+log2(cos(pi*pVector/2))
intervalH=(hdi(Hvector, credMass = 0.95))
intervalp
intervalH


