# rnftools CWL Generation Report

## rnftools_publication

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Total Downloads**: 114.7K
- **Last updated**: 2025-11-12
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
--------------------------------------------------------------------------------------------
  K. Brinda, V. Boeva, G. Kucherov: RNF: a general framework to evaluate NGS read mappers.
        Bioinformatics (2016) 32(1): 136-139. [DOI:10.1093/bioinformatics/btv524].
--------------------------------------------------------------------------------------------

@article{rnftools,
	author  = {B{\v r}inda, Karel AND Boeva, Valentina AND Kucherov, Gregory},
	title   = {RNF: a general framework to evaluate NGS read mappers},
	journal = {Bioinformatics},
	year    = {2016},
	number  = {1},
	volume  = {32},
	pmid    = {26353839},
	doi     = {10.1093/bioinformatics/btv524}
}
```


## rnftools_validate

### Tool Description
Validate RNF names in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools validate [-h] -i file [-w] [-a]

Validate RNF names in a FASTQ file.

options:
  -h, --help            show this help message and exit
  -i, --fastq file      FASTQ file to be validated.
  -w, --warnings-as-errors
                        Treat warnings as errors.
  -a, --all-occurrences
                        Report all occurrences of warnings and errors.
```


## rnftools_liftover

### Tool Description
Liftover genomic coordinates in RNF names in a SAM/BAM files or in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools liftover [-h] [-c file] -g int [-x file] [--invert]
                         [--input-format str] [--output-format str]
                         input output

Liftover genomic coordinates in RNF names in a SAM/BAM files or in a FASTQ
file.

positional arguments:
  input                Input file to be transformed (- for standard input).
  output               Output file to be transformed (- for standard output).

options:
  -h, --help           show this help message and exit
  -c, --chain file     Chain liftover file for coordinates transformation. [no
                       transformation]
  -g, --genome-id int  ID of genome to be transformed.
  -x, --faidx file     Fasta index of the reference sequence. [extract from
                       chain file]
  --invert             Invert chain file (transformation in the other
                       direction).
  --input-format str   Input format (SAM/BAM/FASTQ). [autodetect]
  --output-format str  Output format (SAM/BAM/FASTQ). [autodetect]
```


## rnftools_sam2rnf

### Tool Description
Convert a SAM/BAM file to RNF-FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools sam2rnf [-h] -s file -o file -x file [-g int] [-u]

Convert a SAM/BAM file to RNF-FASTQ.

options:
  -h, --help            show this help message and exit
  -s, --sam file        Input SAM/BAM with true (expected) alignments of the
                        reads (- for standard input).
  -o, --rnf-fastq file  Output FASTQ file (- for standard output).
  -x, --faidx file      FAI index of the reference FASTA file (- for standard
                        input). It can be created using 'samtools faidx'.
  -g, --genome-id int   Genome ID in RNF (default: 1).
  -u, --allow-unmapped  Allow unmapped reads.
```


## rnftools_art2rnf

### Tool Description
Convert an Art SAM file to RNF-FASTQ. Note that Art produces non-standard SAM files and manual editation might be necessary. In particular, when a FASTA file contains comments, Art left them in the sequence name. Comments must be removed in their corresponding @SQ headers in the SAM file, otherwise all reads are considered to be unmapped by this script.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools art2rnf [-h] -s file -o file -x file [-g int] [-u] [-n str]

Convert an Art SAM file to RNF-FASTQ. Note that Art produces non-standard SAM
files and manual editation might be necessary. In particular, when a FASTA
file contains comments, Art left them in the sequence name. Comments must be
removed in their corresponding @SQ headers in the SAM file, otherwise all
reads are considered to be unmapped by this script.

options:
  -h, --help            show this help message and exit
  -s, --sam file        Input SAM/BAM with true (expected) alignments of the
                        reads (- for standard input).
  -o, --rnf-fastq file  Output FASTQ file (- for standard output).
  -x, --faidx file      FAI index of the reference FASTA file (- for standard
                        input). It can be created using 'samtools faidx'.
  -g, --genome-id int   Genome ID in RNF (default: 1).
  -u, --allow-unmapped  Allow unmapped reads.
  -n, --simulator-name str
                        Name of the simulator (for RNF).
```


## rnftools_curesim2rnf

### Tool Description
Convert a CuReSim FASTQ file to RNF-FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools curesim2rnf [-h] -c file -o file -x file [-g int]

Convert a CuReSim FASTQ file to RNF-FASTQ.

options:
  -h, --help            show this help message and exit
  -c, --curesim-fastq file
                        CuReSim FASTQ file (- for standard input).
  -o, --rnf-fastq file  Output FASTQ file (- for standard output).
  -x, --faidx file      FAI index of the reference FASTA file (- for standard
                        input). It can be created using 'samtools faidx'.
  -g, --genome-id int   Genome ID in RNF (default: 1).
```


## rnftools_dwgsim2rnf

### Tool Description
Convert a DwgSim FASTQ file (dwgsim_prefix.bfast.fastq) to RNF-FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools dwgsim2rnf [-h] -p str [-e] -o file -x file [-g int]

Convert a DwgSim FASTQ file (dwgsim_prefix.bfast.fastq) to RNF-FASTQ.

options:
  -h, --help            show this help message and exit
  -p, --dwgsim-prefix str
                        Prefix for DwgSim.
  -e, --estimate-unknown
                        Estimate unknown values.
  -o, --rnf-fastq file  Output FASTQ file (- for standard output).
  -x, --faidx file      FAI index of the reference FASTA file (- for standard
                        input). It can be created using 'samtools faidx'.
  -g, --genome-id int   Genome ID in RNF (default: 1).
```


## rnftools_mason2rnf

### Tool Description
Convert a Mason SAM file to RNF-FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools mason2rnf [-h] -s file -o file -x file [-g int] [-u] [-n str]

Convert a Mason SAM file to RNF-FASTQ.

options:
  -h, --help            show this help message and exit
  -s, --sam file        Input SAM/BAM with true (expected) alignments of the
                        reads (- for standard input).
  -o, --rnf-fastq file  Output FASTQ file (- for standard output).
  -x, --faidx file      FAI index of the reference FASTA file (- for standard
                        input). It can be created using 'samtools faidx'.
  -g, --genome-id int   Genome ID in RNF (default: 1).
  -u, --allow-unmapped  Allow unmapped reads.
  -n, --simulator-name str
                        Name of the simulator (for RNF).
```


## rnftools_wgsim2rnf

### Tool Description
Convert WgSim FASTQ files to RNF-FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools wgsim2rnf [-h] -1 file [-2 file] -o file -x file [-g int] [-u]

Convert WgSim FASTQ files to RNF-FASTQ.

options:
  -h, --help            show this help message and exit
  -1, --wgsim-fastq-1 file
                        First WgSim FASTQ file (- for standard input)
  -2, --wgsim-fastq-2 file
                        Second WgSim FASTQ file (in case of paired-end reads,
                        default: none).
  -o, --rnf-fastq file  Output FASTQ file (- for standard output).
  -x, --faidx file      FAI index of the reference FASTA file (- for standard
                        input). It can be created using 'samtools faidx'.
  -g, --genome-id int   Genome ID in RNF (default: 1).
  -u, --allow-unmapped  Allow unmapped reads.
```


## rnftools_merge

### Tool Description
todo

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools merge [-h] -i inp [inp ...] -m mode -o out

todo

options:
  -h, --help        show this help message and exit
  -i inp [inp ...]  input FASTQ files
  -m mode           mode for mergeing files (single-end / paired-end-bwa / paired-end-bfast)
  -o out            output prefix

Source RNF-FASTQ files should satisfy the following conditions:
	1) Each file contains only reads corresponding to one genome (with the
	   same genome id).
	2) All files contain reads of the same type (single-end / paired-end).
	3) Reads with more reads per tuple (e.g., paired-end) have '/1', etc.
	   in suffix (for identification of nb of read).
```


## rnftools_sam2es

### Tool Description
todo

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools sam2es [-h] -i file -o file [-d int]

todo

options:
  -h, --help            show this help message and exit
  -i, --sam file        SAM/BAM with aligned RNF reads(- for standard input).
  -o, --es file         Output ES file (evaluated segments, - for standard
                        output).
  -d, --allowed-delta int
                        Tolerance of difference of coordinates between true
                        (i.e., expected) alignment and real alignment (very
                        important parameter!) (default: 5).
```


## rnftools_es2et

### Tool Description
todo

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools es2et [-h] -i file -o file

todo

options:
  -h, --help     show this help message and exit
  -i, --es file  Input ES file (evaluated segments, - for standard input).
  -o, --et file  Output ET file (evaluated read tuples, - for standard
                 output).
```


## rnftools_et2roc

### Tool Description
todo

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools et2roc [-h] -i file -o file

todo

options:
  -h, --help      show this help message and exit
  -i, --et file   Input ET file (evaluated read tuples, - for standard input).
  -o, --roc file  Output ROC file (evaluated reads, - for standard output).
```


## rnftools_sam2roc

### Tool Description
todo

### Metadata
- **Docker Image**: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
- **Homepage**: http://karel-brinda.github.io/rnftools
- **Package**: https://anaconda.org/channels/bioconda/packages/rnftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnftools sam2roc [-h] -i file -o file [-d int]

todo

options:
  -h, --help            show this help message and exit
  -i, --sam file        SAM/BAM with aligned RNF reads(- for standard input).
  -o, --roc file        Output ROC file (- for standard output).
  -d, --allowed-delta int
                        Tolerance of difference of coordinates between true
                        (i.e., expected) alignment and real alignment (very
                        important parameter!) (default: 5).
```

