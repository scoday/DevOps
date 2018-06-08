#!/usr/bin/python
#
# Ball Cap Chaos Theory..
# Part of MIT 6.S095
#
caps = ['F', 'F', 'B', 'B', 'B', 'F', 'B', 'B', 'B', 'F', 'F', 'B', 'F']
caps2 = ['F', 'F', 'B', 'B', 'B', 'F', 'B', 'B', 'B', 'F', 'F', 'F', 'F']

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
