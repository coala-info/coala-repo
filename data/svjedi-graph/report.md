# svjedi-graph CWL Generation Report

## svjedi-graph_svjedi-graph.py

### Tool Description
Generates a graph representation of structural variants from VCF, reference, and reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/svjedi-graph:1.2.1--hdfd78af_0
- **Homepage**: https://github.com/SandraLouise/SVJedi-graph
- **Package**: https://anaconda.org/channels/bioconda/packages/svjedi-graph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svjedi-graph/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SandraLouise/SVJedi-graph
- **Stars**: N/A
### Original Help Text
```text
usage: svjedi-graph.py [-h] -v VCF -r REF -q READS -p PREFIX [-t THREADS]
                       [-ms <minNbAln>]

options:
  -h, --help            show this help message and exit
  -v VCF, --vcf VCF     SV set in vcf format
  -r REF, --ref REF     Reference genome in fasta format
  -q READS, --reads READS
                        Long reads in fastq format
  -p PREFIX, --prefix PREFIX
                        Prefix of generated files
  -t THREADS, --threads THREADS
                        Number of threads to use for read mapping
  -ms <minNbAln>, --minsupport <minNbAln>
                        Minimum number of alignments to genotype a SV
                        (default: 3>=)
```

