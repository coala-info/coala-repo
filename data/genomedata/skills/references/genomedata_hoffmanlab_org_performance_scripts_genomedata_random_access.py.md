#!/usr/bin/env python
from \_\_future\_\_ import with\_statement, division
"""Looks up track data in a Genomedata archive at positions on stdin
Usage: cat POSITIONS | ./genomedata\_random\_access.py GENOMEDATADIR TRACKNAME...
Expects lines on stdin of the form: chromindex
Prints the data value for the each trackname at each position in the format:
TABTAB
with a value for each trackname provided, in the order provided.
"""
import sys
import warnings
from genomedata import Genome
with Genome(sys.argv[1]) as genome:
tracknames = sys.argv[2:]
if not tracknames:
print >>sys.stderr, "Using all tracks..."
tracknames = genome.tracknames\_continuous
warnings.simplefilter("ignore") # Ignore supercontig warnings
for line in sys.stdin:
chrom, index = line.strip().split()
for trackname in tracknames:
print str(genome[chrom][int(index), trackname]),
print