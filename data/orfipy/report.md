# orfipy CWL Generation Report

## orfipy

### Tool Description
By default orfipy reports ORFs as sequences between start and stop codons. See ORF searching options to change this behaviour. If no output type, i.e. dna, rna, pep, bed or bed12, is specified, default output is bed format to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/orfipy:0.0.4--py37h96cfd12_1
- **Homepage**: https://github.com/urmi-21/orfipy
- **Package**: https://anaconda.org/channels/bioconda/packages/orfipy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/orfipy/overview
- **Total Downloads**: 25.1K
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/urmi-21/orfipy
- **Stars**: N/A
### Original Help Text
```text
usage: 
    orfipy [<options>] <infile>
    By default orfipy reports ORFs as sequences between start and stop codons. See ORF searching options to change this behaviour.
    If no output type, i.e. dna, rna, pep, bed or bed12, is specified, default output is bed format to stdout.
    

orfipy: extract Open Reading Frames (version 0.0.4)

positional arguments:
  infile                The input file, in plain Fasta/Fastq or gzipped
                        format, containing Nucletide sequences

optional arguments:
  -h, --help            show this help message and exit
  --procs PROCS         Num processor cores to use Default:mp.cpu_count()
  --single-mode         Run in single mode i.e. no parallel processing
                        (SLOWER). If supplied with procs, this is ignored.
                        Default: False
  --table TABLE         The codon table number to use or path to .json file
                        with codon table. Use --show-tables to see available
                        tables compiled from: https://www.ncbi.nlm.nih.gov/Tax
                        onomy/Utils/wprintgc.cgi?chapter=cgencodes Default: 1
  --start START         Comma-separated list of start-codons. This will
                        override start codons described in translation table.
                        E.g. "--start ATG,ATT" Default: Derived from the
                        translation table selected
  --stop STOP           Comma-separated list of stop codons. This will
                        override stop codons described in translation table.
                        E.g. "--start TAG,TTT" Default: Derived from the
                        translation table selected
  --outdir OUTDIR       Path to outdir default: orfipy_<infasta>_out
  --bed12 BED12         bed12 out file Default: None
  --bed BED             bed out file Default: None
  --dna DNA             fasta (DNA) out file Default: None
  --rna RNA             fasta (RNA) out file Default: None
  --pep PEP             fasta (peptide) out file Default: None
  --min MIN             Minimum length of ORF, excluding stop codon
                        (nucleotide) Default: 30
  --max MAX             Maximum length of ORF, excluding stop codon
                        (nucleotide) Default: 1,000,000,000
  --strand {f,r,b}      Strands to find ORFs [(f)orward,(r)everse,(b)oth]
                        Default: b
  --ignore-case         Ignore case and find ORFs in lower case sequences too.
                        Useful for soft-masked sequences. Default: False
  --partial-3           Output ORFs with a start codon but lacking an inframe
                        stop codon. E.g. "ATG TTT AAA" Default: False
  --partial-5           Output ORFs with an inframe stop codon lacking an
                        inframe start codon. E.g. "TTT AAA TAG" Default: False
  --between-stops       Output ORFs defined as regions between stop codons
                        (regions free of stop codon). This will set
                        --partial-3 and --partial-5 true. Default: False
  --include-stop        Include stop codon in the results, if a stop codon
                        exists. This output format is compatible with
                        TransDecoder's which includes stop codon coordinates
                        Default: False
  --longest             Output a separate BED file for longest ORFs per
                        sequence. Requires bed option. Default: False
  --by-frame            Output separate BED files for ORFs by frame. Can be
                        combined with "--longest" to output longest ORFs in
                        each frame. Requires bed option. Default: False
  --chunk-size CHUNK_SIZE
                        Max chunk size in MB. This is useful for limiting
                        memory usage when processing large fasta files using
                        multiple processes The files are processed in chunks
                        if file size is greater than chunk-size. By default
                        orfipy computes the chunk size based on available
                        memory and cpu cores. Providing a smaller chunk-size
                        will lower the memory usage but, actual memory used by
                        orfipy can be more than the chunk-size. Providing a
                        very high chunk-size can lead to memory issues for
                        larger sequences such as large chromosomes. It is best
                        to let orfipy decide on the chunk-size. Default:
                        estimated by orfipy based on system memory and cpu
  --show-tables         Print translation tables and exit. Default: False
  --version             Print version information and exit
```

