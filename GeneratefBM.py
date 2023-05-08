import numpy as np
from fbm import FBM
import matplotlib.pyplot as plt
numberOfPaths=1
zeroCrossingsVector = np.zeros(numberOfPaths)
for k in range(numberOfPaths):
    pathLength = 10000
    zeroCrossings=0
    f = FBM(n=pathLength, hurst=0.9, length=1, method='cholesky')
    fGN=[0]*(pathLength)
    sample=f.fbm()
#%%

    with open('C:\\Users\\dpdim\\Desktop\\Thesis Progs\\path.txt','w') as f:
        for i in sample:
            f.write(str(i)+",")
        
        for j in range(pathLength):
            fGN[j]=sample[j+1]-sample[j]     
        
        plt.plot(sample)
        plt.show()

    for i in range(2,pathLength):
        if(fGN[i]*fGN[i-1]<0):
            zeroCrossings = zeroCrossings+1
        

