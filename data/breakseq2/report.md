# breakseq2 CWL Generation Report

## breakseq2_run_breakseq2.py

### Tool Description
BreakSeq2: Ultrafast and accurate nucleotide-resolution analysis of structural variants

### Metadata
- **Docker Image**: quay.io/biocontainers/breakseq2:2.2--py27_0
- **Homepage**: http://bioinform.github.io/breakseq2
- **Package**: https://anaconda.org/channels/bioconda/packages/breakseq2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/breakseq2/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: run_breakseq2.py [-h] [--bplib BPLIB] --bwa BWA --samtools SAMTOOLS
                        [--min_span MIN_SPAN] [--window WINDOW]
                        [--min_overlap MIN_OVERLAP] [--bplib_gff BPLIB_GFF]
                        [--junction_length JUNCTION_LENGTH]
                        [--format_version {1,2}] [--nthreads NTHREADS] --bams
                        BAMS [BAMS ...] [--work WORK]
                        [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                        --reference REFERENCE [--sample SAMPLE] [--keep_temp]
                        [--version]

BreakSeq2: Ultrafast and accurate nucleotide-resolution analysis of structural
variants

optional arguments:
  -h, --help            show this help message and exit
  --nthreads NTHREADS   Number of processes to use for parallelism (default:
                        1)
  --bams BAMS [BAMS ...]
                        Alignment BAMs (default: [])
  --work WORK           Working directory (default: work)
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of chromosomes to process (default: [])
  --reference REFERENCE
                        Reference FASTA (default: None)
  --sample SAMPLE       Sample name. Leave unspecified to infer sample name
                        from BAMs. (default: None)
  --keep_temp           Keep temporary files (default: False)
  --version             show program's version number and exit

Read alignment options:
  --bplib BPLIB         Breakpoint library FASTA (default: None)
  --bwa BWA             Path to BWA executable (default: None)
  --samtools SAMTOOLS   Path to SAMtools executable (default: None)

BreakSeq core options:
  --min_span MIN_SPAN   Minimum span for junction (default: 10)

Zygosity computation options:
  --window WINDOW       Window size (default: 100)
  --min_overlap MIN_OVERLAP
                        Min overlap (default: 10)

Breakpoint library FASTA generation options:
  --bplib_gff BPLIB_GFF
                        Breakpoint GFF input (default: None)
  --junction_length JUNCTION_LENGTH
                        Junction length (default: 200)
  --format_version {1,2}
                        Version of breakpoint library format to use (default:
                        2)
```

