import sympy as sym
from scipy.optimize import fsolve
import math as m
import numpy as np
#constantOfProp = sc.beta(z,n-z)

def pToH(p):
    return(1+m.log2(m.cos(m.pi*p/2)))

def HTop(H):
    return((2/m.pi)*np.arccos(2**(H-1)))

def calculateBetaMode(alpha,beta):
    return((alpha-1)/(alpha+beta-2))

def calculateB(mean):
    mean=HTop(mean)
    B = sym.symbols('B')
    expr = sym.lambdify(B,(-B*sym.exp(-B)-sym.exp(-B)+1)/(B*(-sym.exp(-B)+1)) - mean)
    return(fsolve(expr,1)[0])

def calculateBetaPar(total,mode):
    mode = HTop(mode) #converting mode of H to the corresponding value of p
    alpha = 1+(total-2)*mode
    beta = total-alpha
    return([alpha,beta])


#a = sym.symbols('a')
#b = sym.symbols('b')
#eq1 = sym.Eq((a-1)/(a+b-2),mode)
#eq2 = sym.Eq(a+b,total)
#result = sym.solve([eq1,eq2],(a,b))
