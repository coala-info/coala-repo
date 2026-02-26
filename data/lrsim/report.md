# lrsim CWL Generation Report

## lrsim

### Tool Description
Simulate linked reads based on reference genome and variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrsim:1.0--pl5321hbcd995c_0
- **Homepage**: https://github.com/aquaskyline/LRSIM
- **Package**: https://anaconda.org/channels/bioconda/packages/lrsim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lrsim/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aquaskyline/LRSIM
- **Stars**: N/A
### Original Help Text
```text
+ perl /usr/local/share/lrsim/simulateLinkedReads.pl -h

    Usage:   /usr/local/share/lrsim/simulateLinkedReads.pl -r/-g <reference/haplotypes> -p <output prefix> [options]

    Reference genome and variants:
    -d INT      Haplotypes to simulate [2]
    -g STRING   Haploid FASTAs separated by comma. Overrides -r and -d.
    -1 INT      1 SNP per INT base pairs [1000]
    -2 INT      Minimum length of Indels  [1]
    -3 INT      Maximum length of Indels  [50]
    -4 INT      # of Indels  [1000]
    -5 INT      Minimum length of Duplications and Inversions [1000]
    -6 INT      Maximum length of Duplications and Inversions [10000]
    -7 INT      # of Duplications and # of Inversions [100]
    -8 INT      Minimum length of Translocations [1000]
    -9 INT      Maximum length of Translocations [10000]
    -0 INT      # of Translocations [100]

    Illumina reads characteristics:
    -e FLOAT    Per base error rate of the first read [0.0001,0.0016]
    -E FLOAT    Per base error rate of the second read [0.0001,0.0016]
    -i INT      Outer distance between the two ends for pairs [350]
    -s INT      Standard deviation of the distance for pairs [35]

    Linked reads parameters:
    -b STRING   Barcodes list
    -x INT      # million reads pairs in total to simulated [600]
    -f INT      Mean molecule length in kbp [100]
    -c STRING   Input a list of fragment sizes
    -t INT      n*1000 partitions to generate [1500]
    -m INT      Average # of molecules per partition [10]

    Miscellaneous:
    -u INT      Continue from a step [auto]
                  1. Variant simulation
                  2. Build fasta index
                  3. DWGSIM
                  4. Simulate reads
                  5. Sort reads extraction manifest
                  6. Extract reads
    -z INT      # of threads to run DWGSIM [8]
    -o          Disable parameter checking
    -h          Show this help

     at /usr/local/share/lrsim/simulateLinkedReads.pl line 676.
```

