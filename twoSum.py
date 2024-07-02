def twoSum(nums, target):
    result = []
    targetDict = {}
    doubleEleCt = 0

    for num in nums:
        if target - num == num:
            doubleEleCt += 1
        targetDict[target - num] = num
    
    # sprint(targetDict)
    for i in range(len(nums)):
        if (nums[i] in targetDict):
            if targetDict[nums[i]] != nums[i]:
                result.append(i)
            else:
                if doubleEleCt % 2 == 0:
                     result.append(i)

    return result

ans = twoSum(nums = [3,2,4], target = 6)
print(ans)