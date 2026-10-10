# metawrap-assembly CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metawrap-assembly_assembly | PASS | megahit assembly of B. fragilis reads: 255 contigs, 1.73 Mb |


## metawrap-assembly_assembly

### Tool Description
metaWRAP assembly module

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-assembly:1.3.0--hdfd78af_3
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-assembly/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap assembly

Usage: metaWRAP assembly [options] -1 reads_1.fastq -2 reads_2.fastq -o output_dir
Options:

	-1 STR          forward fastq reads
	-2 STR          reverse fastq reads
	-o STR          output directory
	-m INT          memory in GB (default=24)
	-t INT          number of threads (defualt=1)
	-l INT		minimum length of assembled contigs (default=1000)

	--megahit	assemble with megahit (default)
	--metaspades	assemble with metaspades instead of megahit (better results but slower and higher memory requirement)
```

