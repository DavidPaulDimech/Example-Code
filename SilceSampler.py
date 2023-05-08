import math
import scipy.special as sc
import sympy as sym
import numpy as np
from tqdm import tqdm
import matplotlib.pyplot as plt


def rootsearch(f,a,b,dx):
    x1 = a; f1 = f(a)
    x2 = a + dx; f2 = f(x2)
    while np.real(f1)*np.real(f2) > 0:
        if x1 >= b:
            return None,None
        x1 = x2; f1 = f2
        x2 = x1 + dx; f2 = f(x2)
    return x1,x2

def bisect(f,x1,x2,switch=0,epsilon=1.0e-9):
    f1 = f(x1)
    if f1 == 0.0:
        return x1
    f2 = f(x2)
    if f2 == 0.0:
        return x2
    if f1*f2 > 0.0:
        print('Root is not bracketed')
        return None
    n = int(math.ceil(math.log(abs(x2 - x1)/epsilon)/math.log(2.0)))
    for i in range(n):
        x3 = 0.5*(x1 + x2); f3 = f(x3)
        if (switch == 1) and (abs(f3) >abs(f1)) and (abs(f3) > abs(f2)):
            return None
        if f3 == 0.0:
            return x3
        if f2*f3 < 0.0:
            x1 = x3
            f1 = f3
        else:
            x2 =x3
            f2 = f3
    return (x1 + x2)/2.0

#def roots(f, a, b, eps=1e-6):
 #    print ('The roots on the interval [%f, %f] are:' % (a,b))
  #   while 1:
   #      x1,x2 = rootsearch(f,a,b,eps)
    #     if x1 != None:
     #        a = x2
      #       root = bisect(f,x1,x2,1)
       #      if root != None:
        #         pass
         #        print (round(root,-int(math.log(eps, 10))))
        # else:
         #    print ('\nDone')
          #   break
        
def roots2(f, a, b, eps=1e-6):
    i=0
    rootArray = np.zeros(2, dtype='float')
    while 1:
        x1,x2 = rootsearch(f,a,b,eps)
        if x1 != None:
            a = x2
            root = bisect(f,x1,x2,1)
            if root != None:
                pass
                rootArray[i] = round(root,-int(math.log(eps, 10)))
                i=i+1
        else:
            return np.sort(rootArray)

def calculateMode(a,b):
    return((a-1)/(a+b-2))

def sliceSampler(initialPoint,chainLength,burnInPeriod):
    tot = chainLength + burnInPeriod
    p = sym.symbols('p')    
    B=-0.7277687920107496
    fExpr= ((math.exp(1)**(-B*p))*(p**55)*((1-p)**45))/(1e-29)
    f=sym.lambdify(p,fExpr)
    chain = np.zeros(tot, dtype='float')
    chain[0] = initialPoint
    for i in tqdm(range(tot-1),desc='Progress Bar'):
        y= np.random.uniform(0,f(chain[i]),1)[0]
        f2=sym.lambdify(p,fExpr - y)
        interval=roots2(f2,0,1)
        value=np.random.uniform(interval[0],interval[1],1)[0]
        chain[i+1] = value
    return(chain[burnInPeriod:burnInPeriod+chainLength])
    
    
# z = no. of zero crossings
# n = length of fBM Path
# B = constant of exponential
# initialPoint = initial point from where to start sampling
# chainLength = length of desired Markov Chain
# burnInPeriod = length of Burn In Period

