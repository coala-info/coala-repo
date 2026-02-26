# metawrap-read-qc CWL Generation Report

## metawrap-read-qc_metawrap read_qc

### Tool Description
Performs quality control on raw sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-read-qc:1.3.0--hdfd78af_3
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-read-qc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metawrap-read-qc/overview
- **Total Downloads**: 46
- **Last updated**: 2025-10-30
- **GitHub**: https://github.com/bxlab/metaWRAP
- **Stars**: N/A
### Original Help Text
```text
metawrap read_qc --help

Usage: metaWRAP read_qc [options] -1 reads_1.fastq -2 reads_2.fastq -o output_dir
Note: the read files have to be named in the name_1.fastq/name_2.fastq convention.
Options:

	-1 STR          forward fastq reads
	-2 STR          reverse fastq reads
	-o STR          output directory
	-t INT          number of threads (default=1)
	-x STR		prefix of host index in bmtagger database folder (default=hg38)

	--skip-bmtagger		dont remove human sequences with bmtagger
	--skip-trimming		dont trim sequences with trimgalore
	--skip-pre-qc-report	dont make FastQC report of input sequences
	--skip-post-qc-report	dont make FastQC report of final sequences
```

