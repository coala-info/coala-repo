# expressbetadiversity CWL Generation Report

## expressbetadiversity_convertToEBD.py

### Tool Description
Convert UniFrac environment files for use with EBD.

### Metadata
- **Docker Image**: quay.io/biocontainers/expressbetadiversity:1.0.10--h9948957_6
- **Homepage**: https://github.com/dparks1134/ExpressBetaDiversity
- **Package**: https://anaconda.org/channels/bioconda/packages/expressbetadiversity/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/expressbetadiversity/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/ExpressBetaDiversity
- **Stars**: N/A
### Original Help Text
```text
usage: convertToEBD.py [-h] inputFile outputFile

Convert UniFrac environment files for use with EBD.

positional arguments:
  inputFile   Input OTU table in sparse or dense UniFrac format.
  outputFile  Output OTU table in EBD format.

options:
  -h, --help  show this help message and exit
```


## expressbetadiversity_ExpressBetaDiversity

### Tool Description
Express Beta Diversity (EBD) for calculating phylogenetic and non-phylogenetic beta-diversity, including jackknife replicates and hierarchical clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/expressbetadiversity:1.0.10--h9948957_6
- **Homepage**: https://github.com/dparks1134/ExpressBetaDiversity
- **Package**: https://anaconda.org/channels/bioconda/packages/expressbetadiversity/overview
- **Validation**: PASS

### Original Help Text
```text
Express Beta Diversity (EBD) v1.0.7 (Jan 18, 2015)
  by Donovan Parks (donovan.parks@gmail.com) and Rob Beiko (beiko@cs.dal.ca)

 Usage: ExpressBetaDiversity -t <tree file> -s <seq file> -c <calculator>
  -h, --help           Produce help message.
  -l, --list-calc      List all supported calculators.
  -u, --unit-tests     Execute unit tests.

  -t, --tree-file      Tree in Newick format (if phylogenetic beta-diversity is desired).
  -s, --seq-count-file Sequence count file.
  -p, --output-prefix  Output prefix (default = output).

  -g, --clustering     Hierarchical clustering method: UPGMA, SingleLinkage, CompleteLinkage, NJ (default = UPGMA).

  -j, --jackknife      Number of jackknife replicates to perform (default = 0).
  -d, --seqs-to-draw   Number of sequence to draw for jackknife replicates.
  -z, --sample-size    Print number of sequences in each sample.

  -c, --calculator     Desired calculator (e.g., Bray-Curtis, Canberra).
  -w, --weighted       Indicates if sequence abundance data should be used.
  -m, --mrca           Apply 'MRCA weightings' to each branch (experimental).
  -r, --strict-mrca    Restrict calculator to MRCA subtree.
  -y, --count          Use count data as opposed to relative proportions.

  -x, --max-data-vecs  Maximum number of profiles (data vectors) to have in memory at once (default = 1000).

  -a, --all            Apply all calculators and cluster calculators at the specified threshold.
  -b, --threshold      Correlation threshold for clustering calculators (default = 0.8).
  -o, --output-file    Output file for cluster of calculators (default = clusters.txt).

  -v, --verbose        Provide additional information on program execution.
```


## expressbetadiversity_convertToFullMatrix.py

### Tool Description
Convert Phylip lower-triangular matrix produced by EBD to full matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/expressbetadiversity:1.0.10--h9948957_6
- **Homepage**: https://github.com/dparks1134/ExpressBetaDiversity
- **Package**: https://anaconda.org/channels/bioconda/packages/expressbetadiversity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convertToFullMatrix.py [-h] inputMatrix outputMatrix

Convert Phylip lower-triangular matrix produced by EBD to full matrix.

positional arguments:
  inputMatrix   Dissimilarity matrix produced by EBD.
  outputMatrix  Output full dissimilarity matrix.

options:
  -h, --help    show this help message and exit
```


## Metadata
- **Skill**: generated
