# strainest CWL Generation Report

## strainest_est

### Tool Description
Estimate relative abundance of strains. The BAM file must be sorted and indexed.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainest:1.2.4--py35_0
- **Homepage**: https://github.com/compmetagen/strainest
- **Package**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/compmetagen/strainest
- **Stars**: N/A
### Original Help Text
```text
Usage: strainest est [OPTIONS] SNP BAM OUTPUT

  Estimate relative abundance of strains. The BAM file must be sorted and
  indexed.

  EXAMPLES

      strainest est snp.dgrp align.bam align -t 4

Options:
  -q, --quality-thr INTEGER       base quality threshold  [default: 20]
  -p, --min-depth-percentile FLOAT
                                  discard positions where the depth of
                                  coverage is lower than the
                                  MIN_DEPTH_PERCENTILE percentile  [default:
                                  10]
  -P, --max-depth-percentile FLOAT
                                  discard positions where the depth of
                                  coverage is higher than the
                                  MAX_DEPTH_PERCENTILE percentile  [default:
                                  90]
  -a, --min-depth-absolute INTEGER
                                  discard positions where the depth of
                                  coverage is lower than the
                                  MIN_DEPTH_ABSOLUTE  [default: 6]
  -b, --min-depth-base FLOAT      filter base counts (set to 0) where they are
                                  lower then MIN_DEPTH_BASE x DoC (applied
                                  independently for each allelic position)
                                  [default: 0.01]
  -d, --max-ident-thr FLOAT       discard genomes with less than MAX_IDENT_THR
                                  maximum identity  [default: 0.95]
  -t, --threads INTEGER           number of threads to use in model selection
                                  [default: 1]
  --help                          Show this message and exit.
```


## strainest_map2snp

### Tool Description
Build the SNP matrix in DGRP format.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainest:1.2.4--py35_0
- **Homepage**: https://github.com/compmetagen/strainest
- **Package**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: strainest map2snp [OPTIONS] REFERENCE MAPPED OUTPUT

  Build the SNP matrix in DGRP format.

  EXAMPLES

      strainest map2snp reference.fna mapped.fna snp.dgrp

Options:
  --help  Show this message and exit.
```


## strainest_mapgenomes

### Tool Description
Map genomes to a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainest:1.2.4--py35_0
- **Homepage**: https://github.com/compmetagen/strainest
- **Package**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: strainest mapgenomes [OPTIONS] GENOMES... REFERENCE MAPPED

  Map genomes to a reference.

  Align one or more genomes to a reference genome. Only the first sequence
  in the reference genome is considered. Input and output files must be in
  FASTA format.

  EXAMPLES

      strainest mapgenome genome1.fna genome2.fna reference.fna mapped.fna

Options:
  --help  Show this message and exit.
```


## strainest_mapstats

### Tool Description
Compute basic statistics on the mapped genomes file.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainest:1.2.4--py35_0
- **Homepage**: https://github.com/compmetagen/strainest
- **Package**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: strainest mapstats [OPTIONS] MAPPED OUTPUT

  Compute basic statistics on the mapped genomes file.

  EXAMPLES

      strainest mapstats mapped.fna stats

Options:
  --help  Show this message and exit.
```


## strainest_snpclust

### Tool Description
Given a SNP matrix (in DGRP format) and a distance matrix, snpdist clusters the profiles returning a SNP matrix containing the representative profiles (SNPOUT) and a cluster file (CLUST).

### Metadata
- **Docker Image**: quay.io/biocontainers/strainest:1.2.4--py35_0
- **Homepage**: https://github.com/compmetagen/strainest
- **Package**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: strainest snpclust [OPTIONS] SNP DIST SNPOUT CLUST

  Given a SNP matrix (in DGRP format) and a distance matrix, snpdist
  clusters the profiles returning a SNP matrix containing the representative
  profiles (SNPOUT) and a cluster file (CLUST).

  EXAMPLES     strainest map2snp reference.fna mapped.fna snp.dgrp

Options:
  -t, --thr FLOAT  distance threshold  [default: 0.01]
  --help           Show this message and exit.
```


## strainest_snpdist

### Tool Description
Compute the Hamming distances between sequences in SNP matrix (in DGRP format). Moreover, it returns the distances histogram in HIST.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainest:1.2.4--py35_0
- **Homepage**: https://github.com/compmetagen/strainest
- **Package**: https://anaconda.org/channels/bioconda/packages/strainest/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: strainest snpdist [OPTIONS] SNP DIST HIST

  Compute the Hamming distances between sequences in SNP matrix (in DGRP
  format). Moreover, it returns the distances histogram in HIST.

  EXAMPLES

      strainest snpdist snp.dgrp dist.txt hist.pdf

Options:
  --help  Show this message and exit.
```


## Metadata
- **Skill**: generated
