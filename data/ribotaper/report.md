# ribotaper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ribotaper_Ribotaper.sh | Failed | image problem: samtools in the image fails to load libncurses.so.5, so the run stops at the first step |
| ribotaper_create_annotations_files.bash | Failed | image problem: R fails to load libncurses.so.5 and tac is missing, so the run exits 0 but the annotation files are empty |
| ribotaper_create_metaplots.bash | Failed | image problem: samtools in the image fails to load libncurses.so.5, so no metaplot data is made |

## ribotaper_create_metaplots.bash

### Tool Description
Create metagene plots from Ribo-seq BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotaper:1.3.1--0
- **Homepage**: https://github.com/boboppie/RiboTaper
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ribotaper/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/boboppie/RiboTaper
- **Stars**: N/A
### Original Help Text
```text
Usage: create_metaplots.bash <ribo.bam> <bedfile> <name>
```

## ribotaper_create_annotations_files.bash

### Tool Description
Create the annotation files RiboTaper needs from a GTF file and an indexed genome FASTA

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotaper:1.3.1--0
- **Homepage**: https://github.com/boboppie/RiboTaper
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotaper/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./create_annotation_files.bash <gtf_file> <genome_fasta_file(indexed)> <use_ccdsid?> <use_appris?> <dest_folder>
```

## ribotaper_Ribotaper.sh

### Tool Description
Run RiboTaper to define translated ORFs from Ribo-seq and RNA-seq alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotaper:1.3.1--0
- **Homepage**: https://github.com/boboppie/RiboTaper
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotaper/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./Ribotaper.sh <Ribo_bamfile> <RNA_bamfile> <annotation_dir> <comma-sep_read_lenghts_ribo> <comma-sep_cutoffs> <n_cores>
```
