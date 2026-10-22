# sdm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sdm | PASS | synthetic data: repo ONT fixture reads trimmed so barcodes start the read; 4 of 6 reads demultiplexed to S0/S1 and PacBio quality filter kept 24 of 25 reads (help lists -base_map but only -map works, so the CWL wraps -map) |

## sdm

### Tool Description
sdm (simple demultiplexer) is a fast, memory efficient program to demultiplex fasta and fastq files or simply do quality filterings on these.

### Metadata
- **Docker Image**: quay.io/biocontainers/sdm:3.11--h077b44d_0
- **Homepage**: https://github.com/hildebra/sdm/
- **Package**: https://anaconda.org/channels/bioconda/packages/sdm/overview
- **Validation**: PASS

### Original Help Text
```text
------------------------------
This is sdm version 3.11 beta help print
------------------------------

sdm (simple demultiplexer) is a fast, memory efficient program to demultiplex fasta and fastq files or simply do quality filterings on these.
Compiled with zlib gzip support
The compiled version does not support multithreading
Select further help topics by typing:
sdm -help_options : print help on configuring options files
sdm -help_flags : help on command line (flags) arguments for sdm
sdm -help_map : base_map files and the keywords for barcodes etc.sdm -v : version information
------------------------------
For more information, please visit the sdm github page: https://github.com/hildebra/sdm
If you find bugs, please report them there.
If you have questions, please contact me at:  falk.hildebrand@gmail.com
```

## Metadata
- **Skill**: generated
