# uvp CWL Generation Report

## uvp

### Tool Description
Call SNPs and InDels

### Metadata
- **Docker Image**: quay.io/biocontainers/uvp:2.7.0--py_0
- **Homepage**: https://github.com/CPTR-ReSeqTB/UVP
- **Package**: https://anaconda.org/channels/bioconda/packages/uvp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uvp/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CPTR-ReSeqTB/UVP
- **Stars**: N/A
### Original Help Text
```text
usage: uvp -q STRING -r STRING -n STRING [-q2 STRING] [-o STRING]
           [--keepfiles] [--bwa] [--all] [--gatk] [--samtools] [-a]
           [-t THREADS] [-k STRING] [-c STRING] [-v] [-h] [--version]

UVP - Call SNPs and InDels

Input:

  -q STRING, --fastq STRING
                        Input FASTQ file
  -r STRING, --reference STRING
                        Reference genome in FASTA format.
  -n STRING, --name STRING
                        Sample name to be used as a prefix.
  -q2 STRING, --fastq2 STRING
                        Second paired-end FASTQ file.

Output:

  -o STRING, --outdir STRING
                        Output directory
  --keepfiles           Keep intermediate files.

Aligners:
  Select a specific aligner.

  --bwa                 Align Illumina reads using bwa. (Default)

Callers:
  Choose program(s) to call SNPs/InDels with.

  --all                 Run all SNP / InDel calling programs.
  --gatk                Run GATK SNP / InDel calling. (Default)
  --samtools            Run SamTools SNP / InDel calling.

Annotation:
  Use snpEff to annotate VCF file

  -a, --annotate        Run snpEff functional annotation.

Optional:

  -t THREADS, --threads THREADS
                        Num CPU threads for parallel execution
  -k STRING, --krakendb STRING
                        Path to kraken database
  -c STRING, --config STRING
                        Config file
  -v, --verbose         Produce status updates of the run.
  -h, --help            Show this help message and exit
  --version             Show program's version number and exit
```

