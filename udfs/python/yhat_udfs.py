from pig_util import outputSchema

# 
# This is where we write python funtions that we can call from pig.
# Pig needs to know the schema of the function, which we specify using
# the @outputSchema decorator
#
@outputSchema('mean:double')
def mean(a, b, c):
    """
    Calculate the mean of 3 values. 
    """
    x = sum([a, b, c])
    return x / 3.0