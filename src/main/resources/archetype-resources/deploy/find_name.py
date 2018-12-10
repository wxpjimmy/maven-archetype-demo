#!/bin/env python
import sys

print(str([x.split(".")[1] for x in sys.argv[1].split("_") if x.split(".")[0] == sys.argv[2]][0]))