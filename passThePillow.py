def passThePillow(n, time):
    
    leftToRight = True
    pos = 1

    for t in range(1, time+1):
        if leftToRight:
            pos += 1
        else:
            pos -=1
        
        if ( t % (n-1) == 0):
            leftToRight = not leftToRight
    
    return pos

ans = passThePillow(n = 4, time = 9)
print(ans)