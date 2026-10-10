# mindthegap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mindthegap_fill | PASS |  |
| mindthegap_find | PASS |  |

## mindthegap_find

### Tool Description
MindTheGap find: insertion breakpoint detection

### Metadata
- **Docker Image**: quay.io/biocontainers/mindthegap:2.3.0--h5ca1c30_6
- **Homepage**: https://github.com/GATB/mindthegap
- **Package**: https://anaconda.org/channels/bioconda/packages/mindthegap/overview
- **Validation**: PASS

### Original Help Text
```text
[help] MindTheGap find: ok via MindTheGap find (--help=ok, -h=ok, -help=ok, (no args)=ok)
ERROR: Option '-ref' is mandatory

[MindTheGap find options]

   [Input / output options]
          -in      (1 arg) :    input read file(s)  [default '']
          -graph   (1 arg) :    input graph file (likely a hdf5 file)  [default '']
          -ref     (1 arg) :    reference genome file
          -bed     (1 arg) :    bed file to restrict breakpoint search in specific regions  [default '']
          -out-tmp (1 arg) :    prefix for output temporary files  [default '.']
          -out     (1 arg) :    prefix for output files  [default '']

   [Graph building options]
          -kmer-size     (1 arg) :    size of a kmer  [default '31']
          -abundance-min (1 arg) :    minimal abundance threshold for solid kmers  [default 'auto']
          -abundance-max (1 arg) :    maximal abundance threshold for solid kmers  [default '2147483647']

   [Detection options]
          -homo-only     (0 arg) :    search only homozygous breakpoints
          -max-rep       (1 arg) :    maximal repeat size detected for fuzzy sites  [default '5']
          -het-max-occ   (1 arg) :    maximal number of occurrences of a kmer in the reference genome allowed for heterozyguous breakpoints  [default '1']
          -insert-only   (0 arg) :    search only insertion breakpoints (do not report other variants)

   [General options]
          -nb-cores   (1 arg) :    number of cores  [default '0']
          -max-disk   (1 arg) :    max disk for graph building (in MBytes)  [default '0']
          -max-memory (1 arg) :    max memory for graph building (in MBytes)  [default '2000']
          -verbose    (1 arg) :    verbosity level  [default '1']
```

## mindthegap_fill

### Tool Description
MindTheGap fill: gap-filler or insertion assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/mindthegap:2.3.0--h5ca1c30_6
- **Homepage**: https://github.com/GATB/mindthegap
- **Package**: https://anaconda.org/channels/bioconda/packages/mindthegap/overview
- **Validation**: PASS

### Original Help Text
```text
[help] MindTheGap fill: ok via MindTheGap fill -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
ERROR: Unknown parameter '-h'

[MindTheGap fill options]

   [Input / output options]
          -in      (1 arg) :    input read file(s)  [default '']
          -graph   (1 arg) :    input graph file (likely a hdf5 file)  [default '']
          -contig  (1 arg) :    contig file  [default '']
          -bkpt    (1 arg) :    breakpoint file  [default '']
          -out     (1 arg) :    prefix for output files  [default '']
          -overlap (1 arg) :    Overlap between input contigs (default, ie. 0 = kmer size)  [default '0']
          -filter  (0 arg) :    do not output low quality insertions (bkpt mode)
          -extend  (0 arg) :    output first-contig extensions of failed gap-fillings in a separate file

   [Graph building options]
          -kmer-size     (1 arg) :    size of a kmer  [default '31']
          -abundance-min (1 arg) :    minimal abundance threshold for solid kmers  [default 'auto']
          -abundance-max (1 arg) :    maximal abundance threshold for solid kmers  [default '2147483647']

   [Assembly options]
          -max-nodes  (1 arg) :    maximum number of nodes in contig graph (nt)  [default '100']
          -max-length (1 arg) :    maximum length of insertions (nt)  [default '10000']
          -fwd-only   (0 arg) :    do not try in reverse direction if no inserted sequence is assembled (bkpt mode)

   [General options]
          -nb-cores   (1 arg) :    number of cores  [default '0']
          -max-disk   (1 arg) :    max disk for graph building   (in MBytes)  [default '0']
          -max-memory (1 arg) :    max memory for graph building (in MBytes)  [default '2000']
          -verbose    (1 arg) :    verbosity level  [default '1']
```
