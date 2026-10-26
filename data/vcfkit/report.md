# vcfkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vcfkit_vk_calc_genotypes | PASS |  |
| vcfkit_vk_calc_sample_hom_gt | PASS |  |
| vcfkit_vk_calc_spectrum | PASS |  |
| vcfkit_vk_call | Failed | image problem: vk call needs the genome folder inside the installed package, which is read-only for the container user |
| vcfkit_vk_filter | PASS |  |
| vcfkit_vk_geno_het_polarization | Failed | image problem: vk geno stops with ModuleNotFoundError for vcfkit.vk |
| vcfkit_vk_geno_transfer_filter | Failed | image problem: vk geno stops with ModuleNotFoundError for vcfkit.vk |
| vcfkit_vk_genome | Failed | image problem: vk genome writes .genome_directory inside the installed package folder, which is read-only for the container user |
| vcfkit_vk_hmm | Failed | image problem: python module pomegranate is missing |
| vcfkit_vk_phylo_fasta | PASS |  |
| vcfkit_vk_phylo_tree | PASS |  |
| vcfkit_vk_primer_indel | Failed | image problem: python module logzero is missing |
| vcfkit_vk_primer_sanger | Failed | image problem: python module logzero is missing |
| vcfkit_vk_primer_snip | Failed | image problem: python module logzero is missing |
| vcfkit_vk_primer_template | Failed | image problem: python module logzero is missing |
| vcfkit_vk_rename | PASS |  |
| vcfkit_vk_tajima | PASS |  |
| vcfkit_vk_vcf2tsv | PASS |  |

## vcfkit_vk_genome

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

## vcfkit_vk_tajima

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

## vcfkit_vk_vcf2tsv

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

## vcfkit_vk_rename

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

## vcfkit_vk_filter

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

## vcfkit_vk_calc_sample_hom_gt

### Tool Description
Calculate the frequency of homozygous genotypes per sample.

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

## vcfkit_vk_calc_genotypes

### Tool Description
Calculate genotype counts and frequencies per site.

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

## vcfkit_vk_calc_spectrum

### Tool Description
Calculate the allele frequency spectrum.

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

## vcfkit_vk_phylo_fasta

### Tool Description
Write a multi-sample FASTA of the variant sites in a VCF.

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

## vcfkit_vk_phylo_tree

### Tool Description
Build a dendrogram from a VCF by neighbour joining or UPGMA.

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

## vcfkit_vk_call

### Tool Description
Compare variants found in sequences (FASTA) against a VCF using BLAST.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    vk call <seq> --ref=<reference> (--all-sites|--vcf-sites) <vcf>

options:
    -h --help                   Show this screen.
    --version                   Show version.
```

## vcfkit_vk_geno_transfer_filter

### Tool Description
Transfer variant-level filters to genotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk geno transfer-filter <vcf>
  vk geno het-polarization <vcf>


tb.py geno transfer-filter

options:
  -h --help                   Show this screen.
  --version                   Show version.
```

## vcfkit_vk_geno_het_polarization

### Tool Description
Polarize heterozygous genotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk geno transfer-filter <vcf>
  vk geno het-polarization <vcf>


tb.py geno transfer-filter

options:
  -h --help                   Show this screen.
  --version                   Show version.
```

## vcfkit_vk_hmm

### Tool Description
Hidden Markov model for imputing genotypes from parental genotypes in linkage studies.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  vk hmm [options] --A=<parent_1> --B=<parent_2> <vcf>

Example

options:
  -h --help                   Show this screen.
  --version                   Show version.
  --vcf-out                   Output VCF instead of intervals.
  --endfill                   Don't leave gaps at the ends of chromosomes.
  --infill                    Fill in missing portions.
  --state=<state>             State probability [default: 0.97].
  --transition=<transition>   Transition probability [default: 1e-9]
```

## vcfkit_vk_primer_template

### Tool Description
Generate primers for variant validation (template mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    vk primer template [options] <vcf>
    vk primer sanger   [options] <vcf>
    vk primer snip     [options] <vcf>
    vk primer indel    [options] <vcf>

options:
    -h --help                   Show this screen.
    --version                   Show version.
    --ref=<reference>           Reference Genome
    --region=<region>           Restrict to region.
    --samples=<samples>         Output genotypes for a sample or set of samples. [default: ALL]
    --template=<template>       The sample template to output [default: ALT]
    --size=<int>                Amplicon size [default: 600-800]
    --box-variants              Add second column for the sequence with the variant boxed.
    --polymorphic               Only output variants that are polymorphic across specified samples.
    --enzymes=<enzymes>         snip-SNP only: Specify groups of restriction enzymes or individual enzymes [default: Common]
    --nprimers=<nprimers>       Maximum number of primers to generate [default: 5]
```

## vcfkit_vk_primer_sanger

### Tool Description
Generate primers for variant validation (sanger mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    vk primer template [options] <vcf>
    vk primer sanger   [options] <vcf>
    vk primer snip     [options] <vcf>
    vk primer indel    [options] <vcf>

options:
    -h --help                   Show this screen.
    --version                   Show version.
    --ref=<reference>           Reference Genome
    --region=<region>           Restrict to region.
    --samples=<samples>         Output genotypes for a sample or set of samples. [default: ALL]
    --template=<template>       The sample template to output [default: ALT]
    --size=<int>                Amplicon size [default: 600-800]
    --box-variants              Add second column for the sequence with the variant boxed.
    --polymorphic               Only output variants that are polymorphic across specified samples.
    --enzymes=<enzymes>         snip-SNP only: Specify groups of restriction enzymes or individual enzymes [default: Common]
    --nprimers=<nprimers>       Maximum number of primers to generate [default: 5]
```

## vcfkit_vk_primer_snip

### Tool Description
Generate primers for variant validation (snip mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    vk primer template [options] <vcf>
    vk primer sanger   [options] <vcf>
    vk primer snip     [options] <vcf>
    vk primer indel    [options] <vcf>

options:
    -h --help                   Show this screen.
    --version                   Show version.
    --ref=<reference>           Reference Genome
    --region=<region>           Restrict to region.
    --samples=<samples>         Output genotypes for a sample or set of samples. [default: ALL]
    --template=<template>       The sample template to output [default: ALT]
    --size=<int>                Amplicon size [default: 600-800]
    --box-variants              Add second column for the sequence with the variant boxed.
    --polymorphic               Only output variants that are polymorphic across specified samples.
    --enzymes=<enzymes>         snip-SNP only: Specify groups of restriction enzymes or individual enzymes [default: Common]
    --nprimers=<nprimers>       Maximum number of primers to generate [default: 5]
```

## vcfkit_vk_primer_indel

### Tool Description
Generate primers for variant validation (indel mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/AndersenLab/VCF-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    vk primer template [options] <vcf>
    vk primer sanger   [options] <vcf>
    vk primer snip     [options] <vcf>
    vk primer indel    [options] <vcf>

options:
    -h --help                   Show this screen.
    --version                   Show version.
    --ref=<reference>           Reference Genome
    --region=<region>           Restrict to region.
    --samples=<samples>         Output genotypes for a sample or set of samples. [default: ALL]
    --template=<template>       The sample template to output [default: ALT]
    --size=<int>                Amplicon size [default: 600-800]
    --box-variants              Add second column for the sequence with the variant boxed.
    --polymorphic               Only output variants that are polymorphic across specified samples.
    --enzymes=<enzymes>         snip-SNP only: Specify groups of restriction enzymes or individual enzymes [default: Common]
    --nprimers=<nprimers>       Maximum number of primers to generate [default: 5]
```

## Metadata
- **Skill**: generated
