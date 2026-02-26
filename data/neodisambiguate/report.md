# neodisambiguate CWL Generation Report

## neodisambiguate

### Tool Description
Disambiguate reads that were mapped to multiple references.

### Metadata
- **Docker Image**: quay.io/biocontainers/neodisambiguate:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/clintval/neodisambiguate
- **Package**: https://anaconda.org/channels/bioconda/packages/neodisambiguate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/neodisambiguate/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-12-18
- **GitHub**: https://github.com/clintval/neodisambiguate
- **Stars**: N/A
### Original Help Text
```text
neodisambiguate 1.1.1

Disambiguate reads that were mapped to multiple references.

Alignment disambiguation is commonly performed on sequencing data from
transduction, transfection, transgenic, or xenographic (including patient
derived xenograft) experiments. This tool works by comparing various alignment
metrics between a template that has been aligned to many different references
in order to determine which reference is the most likely source. Disambiguation
of aligned reads is made per-template and information across primary,
secondary, and supplementary alignments is used as evidence.

All templates which are positively assigned to a single source reference are
written to a reference-specific output BAM file. Any templates with ambiguous
reference assignment are written to an ambiguous input-specific output BAM
file.

Only BAMs produced from bwa, bwa-mem2, minimap2, or STAR are known to be
supported. Input BAMs of arbitrary sort order are accepted, however, an
internal sort to queryname will be performed unless the BAM is already in
queryname sort order. All output BAM files will be written in the same sort
order as the input BAM files. Although paired-end reads will give the most
discriminatory power for disambiguation of short-read sequencing data, this
tool accepts paired, single-end (fragment), and mixed pairing input data.

EXAMPLE:

To disambiguate a sample aligned to human (A) and mouse (B):

```
❯ neodisambiguate -i dna00001.A.bam dna00001.B.bam -o out/dna00001 -n hg38 mm10

❯ tree out/
  out/
  ├── ambiguous-alignments/
  │  ├── dna00001.A.ambiguous.bai
  │  ├── dna00001.A.ambiguous.bam
  │  ├── dna00001.B.ambiguous.bai
  │  └── dna00001.B.ambiguous.bam
  ├── dna00001.hg38.bai
  ├── dna00001.hg38.bam
  ├── dna00001.mm10.bai
  └── dna00001.mm10.bam
```

ARGUMENTS AND OPTIONS:
 required
  -i, --input  <arg>...      The BAMs to disambiguate
  -o, --output  <arg>        The output file prefix (e.g. dir/sample_prefix)

 optional
  -n, --names  <arg>...      The reference assembly names.
                             Defaults to the first assembly in the BAM headers

 system
  -a, --async-io             Use asynchronous I/O for SAM and BAM files
  -c, --compression  <arg>   Default GZIP BAM compression level
  -t, --tmp-dir  <arg>       Directory to use for temporary files

  -h, --help                 Show help message
  -v, --version              Show version of this program

MIT License Copyright 2019, 2024 Clint Valentine
```

