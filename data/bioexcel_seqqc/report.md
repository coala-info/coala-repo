# bioexcel_seqqc CWL Generation Report

## Metadata
- **Skill**: generated

## bioexcel_seqqc_bxcl_seqqc

### Tool Description
This script performs the Sequence Quality Control step of the Cancer Genome Variant pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioexcel_seqqc:0.6--py_0
- **Homepage**: https://github.com/bioexcel/bioexcel_seqqc
- **Package**: https://anaconda.org/channels/bioconda/packages/bioexcel_seqqc/overview
- **Validation**: PASS
### Original Help Text
```text
usage: bxcl_seqqc [-h] [-f F1 F1] [-o PATH] [--tmpdir PATH] [-t T] [-a ADAP]
                  [-q QCFILE] [--trim {F,A,Q}] [-p]

This script performs the Sequence Quality Control step of the Cancer Genome
Variant pipeline.

optional arguments:
  -h, --help           show this help message and exit

Main Pipeline:
  Main arguments used when running pipeline.

  -f, --files F1 F1    Pair of input FastQ files.
  -o, --outdir PATH    Output directory. (default: current directory)
  --tmpdir PATH        Temp directory. (default: system tmp location)
  -t, --threads T      Max number of threads to use. NOTE: not allstages use
                       all threads. (default: 2)
  -a, --adaptseq ADAP  The adapter sequence to be trimmed from the FastQ file.
                       (default: Illumina TruSeq Universal Adapter)
  -q, --qcconf QCFILE  Location of config file. (default: internal config)

Individual Trim stage:
  Additional arguments used when running the trim stage manually with:
  python -m bioexcel_seqqc.runtrim <args>

  --trim {F,A,Q}       The type of trimming to be done on the paired
                       sequences: [A]dapter or [Q]uality trimming, or
                       [F]ull/both. WARNING: For standalone execution of
                       runtrim only! (default: [F]ull)

Configuration file:
  Flags to output example configuration files.

  -p, --printconfig    Print example config files to current directory.
```

