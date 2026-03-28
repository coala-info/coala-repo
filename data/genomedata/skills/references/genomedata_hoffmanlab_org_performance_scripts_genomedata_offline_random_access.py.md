#!/usr/bin/env python
"""
Looks up the data value for the given tracks at each position on stdin.
Usage: ./genomedata\_random\_access.py GENOMEDATADIR TRACKNAME...
Expects lines on stdin of the form: chromindex
"""
from \_\_future\_\_ import with\_statement, division
import sys
import warnings
from collections import defaultdict
from genomedata import Genome
indices = defaultdict(list)
for line in sys.stdin:
tokens = line.strip().split()
if tokens:
chrom, index = line.strip().split()
indices[chrom].append(int(index))
indices = dict(indices) # remove defaultdict behavior
with Genome(sys.argv[1]) as genome:
tracknames = sys.argv[2:]
for trackname in tracknames:
assert trackname in genome.tracknames\_continuous
warnings.simplefilter("ignore")
count = 0
for chrom in indices:
indices[chrom].sort() # Sort by index ascending
index\_iter = iter(indices[chrom])
index = index\_iter.next()
chromosome = genome[chrom]
chrom\_done = False
for supercontig, continuous in chromosome.itercontinuous():
start = supercontig.start
end = supercontig.end
supercontig\_indices = []
if not chrom\_done:
try:
while index < start:
for trackname in tracknames:
print "nan"
index = index\_iter.next()
while index < end:
supercontig\_indices.append(index - start)
index = index\_iter.next()
except StopIteration:
chrom\_done = True
for trackname in tracknames:
col\_index = chromosome.index\_continuous(trackname)
data\_col = continuous[:, col\_index]
for row\_index in supercontig\_indices:
print "%s" % data\_col[row\_index]