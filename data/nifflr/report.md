# nifflr CWL Generation Report

## nifflr_nifflr.sh

### Tool Description
NIFFLR version 2.0.0

### Metadata
- **Docker Image**: quay.io/biocontainers/nifflr:2.0.0--pl5321haf24da9_0
- **Homepage**: https://github.com/alguoo314/NIFFLR
- **Package**: https://anaconda.org/channels/bioconda/packages/nifflr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nifflr/overview
- **Total Downloads**: 663
- **Last updated**: 2025-10-07
- **GitHub**: https://github.com/alguoo314/NIFFLR
- **Stars**: N/A
### Original Help Text
```text
NIFFLR version 2.0.0
Usage: nifflr.sh [options]
Options:
Options (default value in (), *required):
-B, --bases double                      minimum percentage of exon bases in matching K-mers (35.0)
-m, --mer int                           alignment K-mer size (12)
-k, --known float                       minimum (must be > than) intron junction coverage for detection of known transcripts (0.0)
-n, --novel float                       minimum (must be > than) intron junction coverage for detection of novel transcripts (2.0)
-f, --fasta string                      *fasta/fastq file containing the reads, file can ge gzipped, multiple files should be listed in single quotes e.g. 'file1.fastq file2.fastq'
-r, --ref path                          *fasta file containing the genome sequence
-g, --gtf path                          *GTF file for the genome annotation
-p, --prefix string                     prefix of the output files (output)
-t, --threads int                       number of threads (16)
-e, --allowed_exon_gap_or_overlap int   maximum allowed gap or overlap between two adjacent aligned exons for building a valid transcript (15)
-k, --keep                              if set, all the intermediate files will be kept
-h, --help                              this message
-v, --verbose                           verbose mode (False)
--version                               version
```

