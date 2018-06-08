#!/usr/bin/python
#
# Ball Cap Chaos Theory..
# Part of MIT 6.S095
#
caps = ['F', 'F', 'B', 'B', 'B', 'F', 'B', 'B', 'B', 'F', 'F', 'B', 'F']
caps2 = ['F', 'F', 'B', 'B', 'B', 'F', 'B', 'B', 'B', 'F', 'F', 'F', 'F']

# if verbose:
#    def verbosePrint(*args):
#        for arg in args:
#           print arg,
#        print
# else:
#    verbosePrint = lambda *a: None # Nothing function

def pleaseConform(caps):
    # Initialize
    start = 0
    forward = 0
    backward = 0
    intervals = []

    # Determine intervals for where the position is F / B #
    for i in range(1, len(caps)):
        if caps [start] != caps[i]:
            # each interval "is" a tuple with "3" elements (start, end, type)
            intervals.append((start, i-1, caps[start]))

            if caps [start] == 'F':
                forward += 1
            else:
                backward += 1
            start = 1

    # Add the last interval to complete the execution
    intervals.append((start, len(caps) - 1, caps[start]))
    if caps[start] == 'F':
        forward += 1
    else:
        backward += 1

## print (intervals)
## print (forward, backward)
    if forward < backward:
        flip = 'F'
    else:
        flip = 'B'
    for t in intervals:
        if t[2] == flip:
            # if t[0] == t[1] change the output
            print ('People in positions', t[0],
                   'through', t[1], 'flip your caps!')

# verbosePrint
pleaseConform(caps)
# pleaseConform(caps2)
