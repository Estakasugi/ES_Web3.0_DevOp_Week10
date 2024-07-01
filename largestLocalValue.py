def findAllSubMatrix(grid):
    subMatrixList = []

    for i in range(len(grid)-2):
        for j in range(len(grid)-2):
            #print("leftMost is ", grid[i][j])
            temp_arrX = []
            for ct_x in range(3):
                temp_arrY = []
                for ct_y in range(3):
                    temp_arrY.append(grid[i+ct_x][j+ct_y])
                temp_arrX.append(temp_arrY)
            #print(temp_arrX)
            subMatrixList.append(temp_arrX)

    return subMatrixList



def largestLocal(grid):
    #result = [[0]*(len(grid)-2)]*(len(grid)-2)
    result = []
    subMatrixList =  findAllSubMatrix(grid)
    # print(subMatrixList)

    maxArr = []    
    for i in range(len(subMatrixList)):
        maxInSubMatrix = 0
        for j in range(len(subMatrixList[i])):
            maxInRow = max(subMatrixList[i][j])
            if maxInRow > maxInSubMatrix:
                maxInSubMatrix = maxInRow
        maxArr.append(maxInSubMatrix)
    # print(maxArr)

    ct = 0
    tempArr = []
    for i in range(len(maxArr)):
        
        tempArr.append(maxArr[i])
        ct += 1

        if ct == len(grid) - 2:
            # print(tempArr)
            result.append(tempArr.copy())
            tempArr.clear()
            ct = 0

    return result

#grid = [[9,9,8,1],[5,6,2,6],[8,2,6,4],[6,2,2,2]]
grid = [[1,1,1,1,1],[1,1,1,1,1],[1,1,2,1,1],[1,1,1,1,1],[1,1,1,1,1]]
ans = largestLocal(grid)
print(ans)