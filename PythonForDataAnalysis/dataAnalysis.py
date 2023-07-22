# Exercise: Data Analysis 
# FunctionSuppose you have a list of numerical data. 
# Write a Python function called data_analysis that takes a list of numbers as input and 
# returns a dictionary with the following statistics: the mean, median, maximum, minimum, 
# and standard deviation of the data. 
# Use appropriate control flow statements to compute these statistics and return the dictionary.
import statistics
import math

def data_analysis(inputList):
    dict = {}
    sortedList = sorted(inputList)
    print("LENGTH",len(sortedList))
    print(sortedList)
    
    minimun = sortedList[0]
    maximum = sortedList[len(sortedList)-1]
    #max =  sortedList[-1]
   
    #if list not sorted
    minValue = min(inputList)
    maxValue = max(inputList)
    print("MIN: ",str(minValue)," MAX: ",str(maxValue))

    # median1 = statistics.median(inputList)
    # print(median1)
    
    #use for loop inseat of built in function
    sum = 0
    median = 0
    for i in range(len(sortedList)) :      
        sum += i
        if len(sortedList)%2 == 0: #even
            x = len(sortedList)/2
            median = (sortedList[x] + sortedList[x+1])/2
        else:
            y = int(len(sortedList)/2)
            median = sortedList[y]
    #mean
    mean = sum/len(sortedList)

    dict['min'] = minimun
    dict['max'] = maximum
    dict['mean'] = mean
    dict['median'] = median
    print(dict)

inputList = [21, 8, 69, 64, 45, 47, 3, 69, 29, 35, 67, 60, 31, 36, 38, 98, 16, 27, 68, 35, 59]
data_analysis(inputList)
    