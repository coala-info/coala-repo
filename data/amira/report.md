# amira CWL Generation Report

## amira

### Tool Description
Identify acquired AMR genes from bacterial long read sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/amira:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/Danderson123/Amira
- **Package**: https://anaconda.org/channels/bioconda/packages/amira/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amira/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/Danderson123/Amira
- **Stars**: 20
### Original Help Text
```text
usage: amira [-h] [--reads READS] [--assembly ASSEMBLY] --species
             {Escherichia_coli,Klebsiella_pneumoniae,Enterococcus_faecium,Streptococcus_pneumoniae,Staphylococcus_aureus,ESKAPEES}
             --panRG-path PANRG_PATH [--output OUTPUT_DIR]
             [-n NODE_MIN_COVERAGE] [-g GENE_MIN_COVERAGE]
             [--minimum-length-proportion LOWER_GENE_LENGTH_THRESHOLD]
             [--maximum-length-proportion UPPER_GENE_LENGTH_THRESHOLD]
             [--sample-size SAMPLE_SIZE] [--promoter-mutations]
             [--identity IDENTITY] [--coverage COVERAGE]
             [--min-relative-depth MIN_RELATIVE_DEPTH] [--cores CORES]
             [--pandora-path PANDORA_PATH] [--minimap2-path MINIMAP2_PATH]
             [--samtools-path SAMTOOLS_PATH] [--racon-path RACON_PATH]
             [--seed SEED] [--no-sampling] [--quiet] [--debug] [--no-trim]
             [--assemble-paths] [--meta] [--output-component-fastqs]
             [--version]

Identify acquired AMR genes from bacterial long read sequences.

options:
  -h, --help            show this help message and exit
  --reads READS         path to FASTQ file of long reads.
  --assembly ASSEMBLY   path to FASTA of assembly.
  --species {Escherichia_coli,Klebsiella_pneumoniae,Enterococcus_faecium,Streptococcus_pneumoniae,Staphylococcus_aureus,ESKAPEES}
                        The species you want to run Amira on.
  --panRG-path PANRG_PATH
                        Path to pandora panRG ending .panidx.zip.
  --output OUTPUT_DIR   Directory for Amira outputs (default=amira_output).
  -n NODE_MIN_COVERAGE  Minimum threshold for gene-mer coverage in the graph
                        (default=3).
  -g GENE_MIN_COVERAGE  Minimum relative threshold to remove all instances of
                        a gene (default=0.2).
  --minimum-length-proportion LOWER_GENE_LENGTH_THRESHOLD
                        Minimum length threshold to filter a gene from a read
                        (default=0.5).
  --maximum-length-proportion UPPER_GENE_LENGTH_THRESHOLD
                        Maximum length threshold to filter a gene from a read
                        (default=1.5).
  --sample-size SAMPLE_SIZE
                        Number of reads to subsample to (default=500,000).
  --promoter-mutations  Genotype the promoter sequences of certain AMR genes
                        (only for Escherichia_coli).
  --identity IDENTITY   Minimum identity to a reference allele needed to
                        report an AMR gene (default=0.9).
  --coverage COVERAGE   Minimum alignment coverage of a reference allele to
                        keep an AMR gene (default=0.9).
  --min-relative-depth MIN_RELATIVE_DEPTH
                        Minimum relative read depth to keep an AMR gene
                        (default=0.2).
  --cores CORES         Number of CPUs (default=1).
  --pandora-path PANDORA_PATH
                        Path to pandora binary (default=pandora).
  --minimap2-path MINIMAP2_PATH
                        Path to minimap2 binary (default=minimap2).
  --samtools-path SAMTOOLS_PATH
                        Path to samtools binary (default=samtools).
  --racon-path RACON_PATH
                        Path to racon binary (default=racon).
  --seed SEED           Set the seed (default=2025).
  --no-sampling         Do not randomly sample to a maximum of 500,000 input
                        reads (default=False).
  --quiet               Suppress progress updates (default=False).
  --debug               Output Amira debugging files (default=False).
  --no-trim             Prevent trimming of the graph (default=False).
  --assemble-paths      Use Flye to assemble the full reads assigned to each
                        AMR gene copy (default=False).
  --meta                Do not apply any filtering of genes based on coverage
                        (default=False).
  --output-component-fastqs
                        Output FASTQs of the reads for each connected
                        component (default=False).
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
