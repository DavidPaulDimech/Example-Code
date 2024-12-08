import numpy as np
import matplotlib.pyplot as plt

def sequenceTogeneticWalk(sequence):
    if int(len(sequence)) %2 != 0 :
        sequence=sequence[0:int(len(sequence))-1] # ensuring path is even
    geneticWalk = np.zeros(int(len(sequence)/2)+1)
    for i in range(int(len(sequence)/2)):
        if (sequence[i*2:(i+1)*2] == 'AG'):
            geneticWalk[i+1] = geneticWalk[i]+1
        elif(sequence[i*2:(i+1)*2] == 'CT'):
            geneticWalk[i+1] = geneticWalk[i]-1
        else:
            geneticWalk[i+1] = geneticWalk[i]
    return geneticWalk

def fGN(seriesOrWalk):
    differenceWalk=[0]*(len(seriesOrWalk))
    
    for j in range(len(seriesOrWalk)-1):
        differenceWalk[j]=seriesOrWalk[j+1]-seriesOrWalk[j]
    return(differenceWalk)

def getCrossings(seriesOrWalk):
    zeroCrossings=0
    differenceWalk=[0]*(len(seriesOrWalk))
    
    for j in range(len(seriesOrWalk)-1):
        differenceWalk[j]=seriesOrWalk[j+1]-seriesOrWalk[j]
        
    zeroCrossings = sum(1 for i in range(1,len(differenceWalk)) if differenceWalk[i]*differenceWalk[i-1]<0)
    print("No of zero-crossings for path is " + str(zeroCrossings)) 
