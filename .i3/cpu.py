#!/usr/bin/python3
from subprocess import check_output
import re
import sys
import psutil

values = psutil.cpu_percent(percpu=True, interval=0.5)
values = [value / 100 for value in values]
blocks = "▁▂▃▄▅▆▇"
load = "".join(blocks[min(6, int(value * 7))] for value in values)
fraction = sum(values) / len(values)

print(load)
print(load)

# color
if fraction > 0.9:
    print("#cc241d")
    # red background
    # sys.exit(33)
elif fraction > 0.6:
    print("#fabd2f")
else:
    # print("#8ec07c")
    pass
