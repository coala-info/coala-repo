# metawrap-kraken CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metawrap-kraken_metawrap_kraken | Not completed | needs a Kraken database (not available); fixed option order and read staging |

## metawrap-kraken_metawrap_kraken

### Tool Description
Run on any number of fasta assembly files and/or or paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-kraken:1.3.0--hdfd78af_3
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-kraken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metawrap-kraken/overview
- **Total Downloads**: 43
- **Last updated**: 2025-10-30
- **GitHub**: https://github.com/bxlab/metaWRAP
- **Stars**: N/A
### Original Help Text
```text
metawrap kraken --help

Run on any number of fasta assembly files and/or or paired-end reads.
Usage: metaWRAP kraken [options] -o output_dir assembly.fasta reads_1.fastq reads_2.fastq ...
Options:

	-o STR          output directory
	-t INT          number of threads
	-s INT		read subsampling number (default=all)
	--no-preload	do not pre-load the kraken DB into memory (slower, but lower memory requirement)

	Note: you may pass any number of sequence files with the following extensions:
	*.fa *.fasta (assumed to be assembly files) or *_1.fastq and *_2.fastq (assumed to be paired)
```


## Metadata
- **Skill**: generated
