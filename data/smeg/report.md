# smeg CWL Generation Report

## smeg_build_species

### Tool Description
Builds a species database for SMEG.

### Metadata
- **Docker Image**: quay.io/biocontainers/smeg:1.1.5--0
- **Homepage**: https://github.com/ohlab/SMEG
- **Package**: https://anaconda.org/channels/bioconda/packages/smeg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smeg/overview
- **Total Downloads**: 32.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ohlab/SMEG
- **Stars**: N/A
### Original Help Text
```text
Usage:
    smeg build_species <options>
    <options>
    -g        Genomes directory
    -o        Output directory
    -l        File listing a subset of genomes for database building
                [default = use all genomes in 'Genomes directory']
    -p INT    Number of threads [default 4]
    -s FLOAT  SNP assignment threshold (range 0.1 - 1) [default 0.6]
    -t INT    Cluster SNPs threshold for iterative clustering [default 50]
    -i        Ignore iterative clustering
    -a        Activate auto-mode
    -r        Representative genome [default = auto select Rep genome]
    -k        Keep Roary output [default = false]
    -e        Create database ONLY applicable with Reference-based SMEG method
                [default = generate database suitable for both de novo and ref-based methods]
    -h        Display this message
```


## smeg_growth_est

### Tool Description
Estimate growth rate of bacterial populations from sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/smeg:1.1.5--0
- **Homepage**: https://github.com/ohlab/SMEG
- **Package**: https://anaconda.org/channels/bioconda/packages/smeg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    smeg growth_est <options>
    <options>

  ## MAIN OPTIONS ## 
    -r         Reads directory (single-end reads)
    -x         Sample filename extension (fq, fastq, fastq.gz) [default fastq]
    -o         Output directory
    -s         Species database directory
    -m  INT    SMEG method (0 = de novo-based method, 1 = reference-based method) [default = 0]
    -c  FLOAT  Coverage cutoff (>= 0.5) [default 0.5]
    -u  INT    Minimum number of SNPs to estimate growth rate [default = 100]
    -l         Path to file listing a subset of reads for analysis
               [default = analyze all samples in Reads directory]

  ## DE-NOVO BASED APPROACH OPTIONS ## 
    -d  FLOAT  Cluster detection threshold (range 0.1 - 1) [default = 0.2]
    -t  FLOAT  Sample-specific SNP assignment threshold (range 0.1 - 1) [default = 0.6]

  ## REFERENCE BASED APPROACH OPTIONS ##
    -g         File listing reference genomes for growth rate estimation
    -a         File listing FULL PATH to DESMAN-resolved strains in fasta format (core-genes)
    -n  INT    Max number of mismatch [default = use default bowtie2 threshold]

  ## OTHER OPTIONS ##
    -e         merge output tables into a single matrix file and generate heatmap
    -p  INT    Number of threads [default 4]
    -h         Display this message
```

