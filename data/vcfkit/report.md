# vcfkit CWL Generation Report

## vcfkit_vk

### Tool Description
A toolkit for variant calling and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AndersenLab/VCF-kit
- **Stars**: N/A
### Original Help Text
```text
usage:
  vk <command> [<args>...] 
  vk setup
  vk -h | --help
  vk --version

commands:
  calc
  call
  filter
  geno
  genome
  hmm
  phylo
  primer
  rename
  tajima
  vcf2tsv
```


## vcfkit_vk genome

### Tool Description
Manage genome data

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk genome location [<path>]
  vk genome list
  vk genome --search=<term>
  vk genome ncbi [options] --ref=<asm_name> [--accession-chrom-names]
  vk genome wormbase [options] --ref=<asm_name>

options:
  -h --help                   Show this screen.
  --directory=<dir>           Set Genome Directory
```


## vcfkit_vk tajima

### Tool Description
Calculate Tajima's D

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk tajima [--no-header --extra] <window-size> <step-size> <vcf>
  vk tajima [--no-header --extra] <window-size> --sliding <vcf>

options:
  -h --help                   Show this screen.
  --version                   Show version.
  --window-size               Size of window
  --step-size                 Distance to move window.
  --extra                     display extra

command:
  tajima        Calculate Tajima's D


output:
    CHROM
    BIN_START
    BIN_END
    N_Sites
    N_SNPs
    TajimaD
```


## vcfkit_vk calc

### Tool Description
Calculate various statistics from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk calc sample_hom_gt <vcf>
  vk calc genotypes [--frequency] <vcf>
  vk calc spectrum <vcf>

Example

options:
  -h --help                   Show this screen.
  --version                   Show version.
```


## vcfkit_vk primer

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/site-packages/vcfkit/primer.py", line 25, in <module>
    from logzero import logger
ModuleNotFoundError: No module named 'logzero'
```


## vcfkit_vk phylo

### Tool Description
Phylogenetic analysis tools for VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk phylo fasta <vcf> [<region>]
  vk phylo tree (nj|upgma) [--plot] <vcf> [<region>]

options:
  -h --help                   Show this screen.
  --version                   Show version.
```


## vcfkit_vk vcf2tsv

### Tool Description
Convert VCF to TSV format

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk vcf2tsv (wide|long) [--print-header --ANN] <vcf>

options:
  -h --help                   Show this screen.
  --version                   Show version.
```


## vcfkit_vk rename

### Tool Description
Rename samples in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk rename [--prefix=<prefix> --suffix=<suffix> --subst=<subst>...] <vcf>

options:
  -h --help                   Show this screen.
  --version                   Show version.
```


## vcfkit_vk filter

### Tool Description
Filter VCF based on genotype counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk filter (REF|HET|ALT|MISSING) [--min=<min> --max=<max> --soft-filter=<soft> --mode=(+|x)] <vcf>

Example

options:
  -h --help                   Show this screen.
  --version                   Show version.
```


## vcfkit_vk hmm

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/site-packages/vcfkit/hmm.py", line 26, in <module>
    import pomegranate
ModuleNotFoundError: No module named 'pomegranate'
```

