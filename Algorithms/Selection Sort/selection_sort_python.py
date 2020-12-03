array = [64, 21, 43, 46]

#### ALGORITHM START

# Loop through the array starting at the 
# first index and ending at the second to last
for i in range(len(array)-1): 
    # Set the index with the smallest value to
    # our current i value
    index_smallest_num = i 
    
    # Now we can compare our smallestIndex (i)
    # with every other element in the array.
    # We start with the value next to i which
    # is i + 1
    for j in range(i+1, len(array)): 
        if array[index_smallest_num] > array[j]: 
            index_smallest_num = j 

    # Swap the elements i and smallestIndex are
    # pointing to
    array[i], array[index_smallest_num] = array[index_smallest_num], array[i]


#### ALGORITHM END


print(array)