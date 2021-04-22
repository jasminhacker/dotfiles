#!/usr/bin/python3
import i3ipc
import sys

i3 = i3ipc.Connection()
tree = i3.get_tree()
scratch = tree.find_titled("scratchpad-terminal")
sys.exit(len(scratch))
