# jolytree CWL Generation Report

## jolytree_JolyTree.sh

### Tool Description
A fast alignment-free bioinformatics procedure to infer accurate distance-based phylogenetic trees from genome assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/jolytree:2.1--hdfd78af_0
- **Homepage**: https://research.pasteur.fr/fr/software/jolytree/
- **Package**: https://anaconda.org/channels/bioconda/packages/jolytree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jolytree/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
[1m JolyTree v2.1.211019ac                         Copyright (C) 2017-2021 Institut Pasteur[0m

 Criscuolo A  (2019)  A fast alignment-free  bioinformatics procedure to  infer accurate 
 distance-based phylogenetic trees from genome assemblies. RIO. doi:10.3897/rio.5.e36178 

 Criscuolo A  (2020)  On the transformation of  MinHash-based uncorrected distances into 
 proper   evolutionary    distances   for    phylogenetic   inference.    F1000Research.
 doi:10.12688/f1000research.26930.1

 USAGE:  JolyTree.sh  -i <directory>  -b <basename>  [options]

 OPTIONS:

    -i <directory>  directory name containing  FASTA-formatted contig files;  only files
                    ending with .fa, .fna, .fas or .fasta will be considered (mandatory)
    -b <basename>   basename of every written output file (mandatory)
    -q <real>       probability of observing a random k-mer (default: 0.000000001)
    -k <int>        k-mer size (default: estimated from the largest genome size with the
                    probability set by option -q)
    -s <real|int>   sketch size estimated as the  proportion (up to 1.00) of the average 
                    genome size;  the sketch size (integer > 2) can also be directly set 
                    using this option (default: 0.25)
    -c <real>       if at least one of the estimated p-distances is above this specified
                    cutoff, then a F81/EI correction is performed (default: 0.1)
    -a <real>       F81/EI transformation gamma shape parameter (default: 1.5)
    -f              using  the  four nucleotide  frequencies in  F81/EI  transformations  
                    (default:  to  deal  with  multiple  contig  files,   only  the  two 
                    frequencies A+T and C+G are used)
    -n              no BME tree inference (only pairwise distance estimates)
    -r <int>        number of steps  when performing the  ratchet-based  BME tree search
                    (default: 100)
    -x              no branch support
    -t <int>        number of threads (default: 2)
```

