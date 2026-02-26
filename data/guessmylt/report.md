# guessmylt CWL Generation Report

## guessmylt_GUESSmyLT

### Tool Description
GUESSmyLT, GUESS my Library Type. Can predict the library type used for RNA-Seq. The prediction is based on the orientaion of your read file(s) in .fastq/.fastq.gz/.bam format. Knowing the library type helps you with downstream analyses since it greatly improves the assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/guessmylt:0.2.5--py_0
- **Homepage**: https://github.com/NBISweden/GUESSmyLT
- **Package**: https://anaconda.org/channels/bioconda/packages/guessmylt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/guessmylt/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NBISweden/GUESSmyLT
- **Stars**: N/A
### Original Help Text
```text
usage: GUESSmyLT [-h] [--organism ORGANISM] [--reads READS [READS ...]]
                 [--subsample SUBSAMPLE] [--reference REFERENCE] [--mode MODE]
                 [--annotation ANNOTATION] [--mapped MAPPED]
                 [--threads THREADS] [--memory MEMORY] [--output OUTPUT] [-n]

GUESSmyLT, GUESS my Library Type. Can predict the library type used for RNA-
Seq. The prediction is based on the orientaion of your read file(s) in
.fastq/.fastq.gz/.bam format. Knowing the library type helps you with
downstream analyses since it greatly improves the assembly.

optional arguments:
  -h, --help            show this help message and exit
  --organism ORGANISM   Mandatory when no annotation provided. What organism
                        are you dealing with? prokaryote or eukaryote.
  --reads READS [READS ...]
                        One or two read files in .fastq or .fastq.gz format.
                        Files can be compressed or uncrompressed. Handles
                        interleaved read files and any known .fastq header
                        format.
  --subsample SUBSAMPLE
                        Number of subsampled reads that will be used for
                        analysis. Must be an even number.
  --reference REFERENCE
                        Mandatory when --mapped used or when no reads provided
                        (--reads). Reference file in .fa/.fasta format.
                        Reference can be either transcriptome or genome.
  --mode MODE           Mode can be genome or transcriptome (default genome).
                        It defines how the reference fasta file will be
                        handled by BUSCO. This option is used when no
                        annotation is provided (--annotation).
  --annotation ANNOTATION
                        Annotation file in .gff format. Needs to contain
                        genes.
  --mapped MAPPED       Mapped file in .bam format (Will be sorted). Reference
                        that reads have been mapped to has to be provided.
  --threads THREADS     The number of threads that can be used by GUESSmyLT.
                        Needs to be an integer. Defualt value is 2.
  --memory MEMORY       Maximum memory that can be used by GUESSmyLT in GB.
                        E.g. '10G'. Default value is 8G.
  --output OUTPUT       Full path to output directory. Default is working
                        directory.
  -n                    (Snakemake dryrun option) Allows to see the scheduling
                        plan including the assigned priorities.
```

