#!/usr/bin/env python
import sys
from pathlib import Path
from Bio import SeqIO

gb, prefix = sys.argv[1], sys.argv[2]
records = list(SeqIO.parse(gb, "genbank"))
SeqIO.write(records, prefix + ".fasta", "fasta")