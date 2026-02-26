# decenttree CWL Generation Report

## decenttree

### Tool Description
v1.0.0 for Linux 64-bit
Based on algorithms (UPGMA, NJ, BIONJ) proposed by Sokal & Michener [1958],
Saitou & Nei [1987], Gascuel [1997] and [2009]
Incorporating (in NJ-R and BIONJ-R) techniques proposed by Simonson, Mailund, and Pedersen [2011]
Developed by Olivier Gascuel [2009], Hoa Sien Cuong [2009], James Barbetti [2020-22]

### Metadata
- **Docker Image**: quay.io/biocontainers/decenttree:1.0.0--h3f9e6b0_0
- **Homepage**: https://github.com/iqtree/decenttree
- **Package**: https://anaconda.org/channels/bioconda/packages/decenttree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/decenttree/overview
- **Total Downloads**: 136
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/iqtree/decenttree
- **Stars**: N/A
### Original Help Text
```text
decentTree v1.0.0 for Linux 64-bit
Based on algorithms (UPGMA, NJ, BIONJ) proposed by Sokal & Michener [1958],
Saitou & Nei [1987], Gascuel [1997] and [2009]
Incorporating (in NJ-R and BIONJ-R) techniques proposed by Simonson, Mailund, and Pedersen [2011]
Developed by Olivier Gascuel [2009], Hoa Sien Cuong [2009], James Barbetti [2020-22]
(To suppress this banner pass -no-banner)
Usage: decenttree (-fasta [fastapath] | -phylip [phypath])
       (-msa-out [msapath]) (-strip-name [stripped]) 
       (-name-replace [reps]) (-truncate-name-at [chars])
       (-uncorrected) (-no-matrix) (-dist-out [distout]) (-out-format [shape])
       (-alphabet [states]) (-unknown [chars]) (-not-dna))
       -in [mldist] (-c [level]) (-f [prec]) -out [newick] -t [algorithm]
       (-nt [threads]) (-gz) (-no-banner) (-q)
Arguments in parentheses () are optional.
[msapath]    is the path of a .msa format file, to which the input
             alignment is to be written (in .msa format).
[fastapath]  is the path of a .fasta format file specifying an alignment
             of genetic sequences (file may be in .gz format)
[phypath]    is the path of a .phy format file specifying an alignment
             genetic sequences (file may be in .gz format)
             (by default, the character indicating an unknown state is 'N')
[stripped]   is a list of characters to replace in taxon names, e.g. " /"
[rep]        is a list of characters to replace them with e.g. "_"
             (may be shorter than [strippped]; if so first character is the default.
[distout]    is the path, of a file, into which the distance matrix is to be written
             (possibly in a .gz format)
[shape]      is the shape of a distance matrix output
             (square for square, upper or lower for triangular)
[states]     are the characters for each site
[chars]      are the characters that indicate a site has an unknown character.
[mldist]     is the path of a distance matrix file (which may be in .gz format)
[newick]     is the path to write the newick tree file to (if it ends in .gz it will be compressed)
[threads]    is the number of threads, which should be between 1 and the number of CPUs.
-q           asks for quiet (less progress reporting).
-uncorrected turns off Jukes-Cantor distance correction (only relevant if -fasta supplied).
-not-dna     indicates number of states to be determined from input (if -fasta supplied).
-num         indicates sequence names will be replaced with A1, A2, ... in outputs.
[level]      is a compression level between 1 and 9 (default 5)
[prec]       is a precision (default 6)
[algorithm]  is one of the following, supported, distance matrix algorithms:
AUCTION: Auction Joining
BENCHMARK: Benchmark
BIONJ: BIONJ (Gascuel, Cong [2009])
BIONJ-R: Rapid BIONJ (Saitou, Nei [1987], Gascuel [2009], Simonson Mailund Pedersen [2011])
BIONJ-V: Vectorized BIONJ (Gascuel, Cong [2009])
BIONJ2009: The reference (2009) version of BIONJ (with OMP parallelization)
NJ: Neighbour Joining (Saitou, Nei [1987])
NJ-R: Rapid Neighbour Joining (Simonsen, Mailund, Pedersen [2011])
NJ-R-D: Double precision Rapid Neighbour Joining
NJ-R-V: Rapid Neighbour Joining (Vectorized) (Simonsen, Mailund, Pedersen [2011])
NJ-V: Vectorized Neighbour Joining (Saitou, Nei [1987])
ONJ-R: Rapid Neighbour Joining (a rival version) (Simonsen, Mailund, Pedersen [2011])
ONJ-R-V: Rapid Neighbour Joining (a rival version) (Simonsen, Mailund, Pedersen [2011]) (Vectorized)
RapidNJ: Rapid Neighbour Joining (Simonsen, Mailund, Pedersen [2011])
UNJ: Unweighted Neighbour Joining (Gascel [1997])
```

