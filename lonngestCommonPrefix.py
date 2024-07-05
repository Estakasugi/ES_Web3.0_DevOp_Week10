"""
14. Longest Common Prefix

Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string "".

Example 1:

Input: strs = ["flower","flow","flight"]
Output: "fl"
Example 2:

Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
"""

def longestCommonPrefix(strs):

    if len(strs) == 1:
        return strs[0]
    
    j = 1
    for i in range(len(strs)-1):
        longest = ""
        for ct in range(min(len(strs[i]), len(strs[j]))):
            if strs[i][ct] == strs[j][ct]:
                longest += (strs[i][ct])
            else:
                break

        strs[j] = longest
        j += 1

    return longest


ans = longestCommonPrefix(strs = ["cir","car"])
print(ans)