# imfusion CWL Generation Report

## imfusion_insertions

### Tool Description
imfusion

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/iamsh4shank/Imfusion
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/imfusion/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/iamsh4shank/Imfusion
- **Stars**: N/A
### Original Help Text
```text
usage: imfusion [-h] [--version] {ctg,insertions,expression,build,merge}

positional arguments:
  {ctg,insertions,expression,build,merge}

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```


## imfusion_expression

### Tool Description
imfusion-expression: error: the following arguments are required: --sample_dir, --reference

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/iamsh4shank/Imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-expression [-h] [--version] --sample_dir SAMPLE_DIR
                           --reference REFERENCE [--output OUTPUT] [--paired]
                           [--stranded {stranded,reverse,unstranded}]
imfusion-expression: error: the following arguments are required: --sample_dir, --reference
```


## imfusion_build

### Tool Description
imfusion

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/iamsh4shank/Imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion [-h] [--version] {expression,merge,insertions,ctg,build}

positional arguments:
  {expression,merge,insertions,ctg,build}

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```


## imfusion_ctg

### Tool Description
imfusion-ctg: error: the following arguments are required: --insertions, --reference, --output

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/iamsh4shank/Imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-ctg [-h] [--version] --insertions INSERTIONS --reference
                    REFERENCE [--gene_ids GENE_IDS [GENE_IDS ...]] --output
                    OUTPUT [--threshold THRESHOLD] [--pattern PATTERN]
                    [--window WINDOW WINDOW]
                    [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                    [--min_depth MIN_DEPTH] [--expression EXPRESSION]
                    [--de_threshold DE_THRESHOLD]
imfusion-ctg: error: the following arguments are required: --insertions, --reference, --output
```


## imfusion_merge

### Tool Description
Merges multiple samples into a single imfusion object.

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/iamsh4shank/Imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-merge [-h] [--version] --sample_dirs SAMPLE_DIRS
                      [SAMPLE_DIRS ...] --output OUTPUT
                      [--names NAMES [NAMES ...]]
                      [--output_expression OUTPUT_EXPRESSION]
imfusion-merge: error: the following arguments are required: --sample_dirs, --output
```


## Metadata
- **Skill**: not generated
