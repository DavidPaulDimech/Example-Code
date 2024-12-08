import numpy as np
from fbm import FBM
numberOfPaths=1
pathLength = 10000
zeroCrossingsVector = np.zeros(numberOfPaths)
for k in range(numberOfPaths):
    zeroCrossings=0
    f = FBM(n=pathLength, hurst=0.7, length=1, method='cholesky')
    fGN=[0]*(pathLength)
    sample=f.fbm()

    for j in range(pathLength):
        fGN[j]=sample[j+1]-sample[j]     
        
        
    for i in range(1,pathLength):
        if(fGN[i]*fGN[i-1]<0):
            zeroCrossings = zeroCrossings+1
    zeroCrossingsVector[k] = zeroCrossings             
print("Mean number of Zero crossings is " + str(np.mean(zeroCrossingsVector)))
