"""
350. Intersection of Two Arrays II
Solved
Easy
Topics
Companies
Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.

 

Example 1:

Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2,2]
Example 2:

Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [4,9]
"""

def intersect(nums1, nums2):
    result = []

    nums1Dict = {}
    for i in range(len(nums1)):
        if nums1[i] in nums1Dict:
            nums1Dict[nums1[i]]+=1
        else:
            nums1Dict[nums1[i]] = 1
    
    for num in nums2:
        if num in nums1Dict and nums1Dict[num] > 0:
            result.append(num)
            nums1Dict[num] -= 1

    # print(nums1Dict)

    return result

ans = intersect( nums1 = [4,9,5], nums2 = [9,4,9,8,4])
print(ans)
