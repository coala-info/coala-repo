# gaas CWL Generation Report

## gaas_gaas_create_annotation_project.pl

### Tool Description
A fasta file for genome assembly must be provided (-g)

### Metadata
- **Docker Image**: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
- **Homepage**: https://github.com/NBISweden/GAAS
- **Package**: https://anaconda.org/channels/bioconda/packages/gaas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gaas/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/NBISweden/GAAS
- **Stars**: N/A
### Original Help Text
```text
A fasta file for genome assembly must be provided (-g)

perl /usr/local/bin/gaas_create_annotation_project.pl
	Getting help:
	[-help]
	Input:
	[-s species_name]
	[-g genome.fa]
	[-v assembly version]
```


## gaas_gaas_fasta_statistics.pl

### Tool Description
Get some basic statistics about a nucleotide fasta file. e.g Number of
    sequence, Number of nucleotide, N50, GC-content, etc. It can also create
    R plots about contig size distribution. The plots are performed only if
    an output is given. This script is not designed for AA/Protein
    sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
- **Homepage**: https://github.com/NBISweden/GAAS
- **Package**: https://anaconda.org/channels/bioconda/packages/gaas/overview
- **Validation**: PASS

### Original Help Text
```text
------------------------------------------------------------------------------
|   Genome Assembly Annotation Service (AGAT) - Version: v1.1.0              |
|   https://github.com/NBISweden/AGAT                                          |
|   National Bioinformatics Infrastructure Sweden (NBIS) - www.nbis.se         |
 ------------------------------------------------------------------------------
  

Name:
    gaas_fasta_statistics.pl

Description:
    Get some basic statistics about a nucleotide fasta file. e.g Number of
    sequence, Number of nucleotide, N50, GC-content, etc. It can also create
    R plots about contig size distribution. The plots are performed only if
    an output is given. This script is not designed for AA/Protein
    sequences.

Usage:
        ./gaas_fasta_statistics.pl --f=infile [--output=Directory]
        ./gaas_fasta_statistics.pl --help

Options:
    --f, --infile or -f
            Input fasta file containing DNA sequences.

    --out, --output or -o
            [OPTIONAL] Output directory where diffrent output files will be
            written. If no output is specified, the result will written to
            STDOUT.

    --help or -h
            Display this helpful text.
```

