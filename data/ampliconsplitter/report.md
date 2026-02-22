# ampliconsplitter CWL Generation Report

## ampliconsplitter

### Tool Description
FAIL to generate CWL: ampliconsplitter not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampliconsplitter:1.9.22--h9948957_0
- **Homepage**: https://github.com/RolandFaure/AmpliconSplitter
- **Package**: https://anaconda.org/channels/bioconda/packages/ampliconsplitter/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/ampliconsplitter/overview
- **Total Downloads**: 354
- **Last updated**: 2025-07-30
- **GitHub**: https://github.com/RolandFaure/AmpliconSplitter
- **Stars**: 0
### Generation Failed

FAIL to generate CWL: ampliconsplitter not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: ampliconsplitter not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## ampliconsplitter_ampliconsplitter.py

### Tool Description
AmpliconSplitter separates sequencing reads based on reference amplicons.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampliconsplitter:1.9.22--h9948957_0
- **Homepage**: https://github.com/RolandFaure/AmpliconSplitter
- **Package**: https://anaconda.org/channels/bioconda/packages/ampliconsplitter/overview
- **Validation**: PASS
### Original Help Text
```text
********************
	*                  *
	* AmpliconSplitter *
	*     Welcome!     *
	*                  *
	********************

usage: ampliconsplitter.py [-h] -r REF -f FASTQ [-p POLISHER] [-t THREADS]
                           -o OUTPUT [-u RESCUE_SNPS] [-q MIN_READ_QUALITY]
                           [--resume] [-F] [-l] [--no_clean]
                           [--path_to_medaka PATH_TO_MEDAKA]
                           [--path_to_python PATH_TO_PYTHON]
                           [--path_to_raven PATH_TO_RAVEN] [-v] [-d]

options:
  -h, --help            show this help message and exit
  -r, --ref REF         Reference amplicon(s) to separate in several
                        amplicon(s) (required)
  -f, --fastq FASTQ     Sequencing reads fastq or fasta (required)
  -p, --polisher POLISHER
                        {racon, medaka} medaka is more accurate but much
                        slower [racon]
  -t, --threads THREADS
                        Number of threads [1]
  -o, --output OUTPUT   Output directory
  -u, --rescue_snps RESCUE_SNPS
                        Consider automatically as true all SNPs shared by
                        proportion u of the reads [0.33]
  -q, --min-read-quality MIN_READ_QUALITY
                        If reads have an average quality below this threshold,
                        filter out (fastq input only) [0]
  --resume              Resume from a previous run
  -F, --force           Force overwrite of output folder if it exists
  -l, --low-memory      Turn on the low-memory mode (at the expense of speed)
  --no_clean            Don't clean the temporary files
  --path_to_medaka PATH_TO_MEDAKA
                        Path to the executable medaka [medaka]
  --path_to_python PATH_TO_PYTHON
                        Path to python [python]
  --path_to_raven PATH_TO_RAVEN
                        Path to raven [raven]
  -v, --version         Print version and exit
  -d, --debug           Debug mode
```

