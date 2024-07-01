def threeConsecutiveOdds(arr):
    counter = 0

    for i in range(len(arr)):
        if arr[i] % 2 != 0:
            counter += 1
        else:
            counter = 0
        
        if counter == 3:
            return True

    return False

#arr = [1,2,34,3,4,5,7,23,12]
arr = [2,6,4,1]
ans = threeConsecutiveOdds(arr)

print(ans)