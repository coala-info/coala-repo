# transanno CWL Generation Report

## transanno_left-align

### Tool Description
Left align and normalize chain file

### Metadata
- **Docker Image**: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
- **Homepage**: https://github.com/informationsea/transanno
- **Package**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/informationsea/transanno
- **Stars**: N/A
### Original Help Text
```text
Left align and normalize chain file

Usage: transanno left-align --output <OUTPUT> --original <ORIGINAL_SEQUENCE> --new <NEW_SEQUENCE> <ORIGINAL_CHAIN>

Arguments:
  <ORIGINAL_CHAIN>  Original chain file

Options:
  -o, --output <OUTPUT>               Output chain file
  -r, --original <ORIGINAL_SEQUENCE>  Original assembly FASTA (.fai file is required)
  -q, --new <NEW_SEQUENCE>            New assembly FASTA (.fai file is required)
  -h, --help                          Print help
```


## transanno_chain-to-bed-vcf

### Tool Description
Create BED and VCF file from chain file

### Metadata
- **Docker Image**: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
- **Homepage**: https://github.com/informationsea/transanno
- **Package**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Validation**: PASS

### Original Help Text
```text
Create BED and VCF file from chain file

Usage: transanno chain-to-bed-vcf [OPTIONS] --output-original-bed <REFERENCE_BED> --output-new-bed <QUERY_BED> --output-original-vcf <REFERENCE_VCF> --output-new-vcf <QUERY_VCF> --original <REFERENCE_SEQUENCE> --new <QUERY_SEQUENCE> <CHAIN>

Arguments:
  <CHAIN>  Input Chain file

Options:
  -b, --output-original-bed <REFERENCE_BED>
          Output original assembly BED file (Not sorted)
  -d, --output-new-bed <QUERY_BED>
          Output new assembly BED file (Not sorted)
  -v, --output-original-vcf <REFERENCE_VCF>
          Output original assembly VCF file (Not sorted)
  -c, --output-new-vcf <QUERY_VCF>
          Output new assembly VCF file (Not sorted)
  -r, --original <REFERENCE_SEQUENCE>
          Original assembly FASTA (.fai file is required)
  -q, --new <QUERY_SEQUENCE>
          New assembly FASTA (.fai file is required)
  -s, --svlen <SVLEN>
          Do not write nucleotides if a length of reference or alternative sequence is longer than svlen [default: 50]
  -h, --help
          Print help
```


## transanno_liftgene

### Tool Description
Lift GENCODE or Ensemble GFF3/GTF file

### Metadata
- **Docker Image**: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
- **Homepage**: https://github.com/informationsea/transanno
- **Package**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Validation**: PASS

### Original Help Text
```text
Lift GENCODE or Ensemble GFF3/GTF file

Usage: transanno liftgene [OPTIONS] --chain <CHAIN> --output <OUTPUT> --failed <FAILED> <GFF>

Arguments:
  <GFF>  input GFF3/GTF file (GENCODE/Ensemble)

Options:
  -c, --chain <CHAIN>    chain file
      --format <FORMAT>  Input file format [default: auto] [possible values: auto, gff3, gtf]
  -o, --output <OUTPUT>  GFF3/GTF output path (unsorted)
  -f, --failed <FAILED>  Failed to liftOver GFF3/GTF output path
  -h, --help             Print help
```


## transanno_minimap2chain

### Tool Description
Convert minimap2 result to chain file

### Metadata
- **Docker Image**: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
- **Homepage**: https://github.com/informationsea/transanno
- **Package**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Validation**: PASS

### Original Help Text
```text
Convert minimap2 result to chain file

A paf file should be created with a command shown in below.

$ minimap2 -cx asm5 --cs NEW_FASTA ORIGINAL_FASTA > PAF_FILE.paf


Usage: transanno minimap2chain --output <OUTPUT> <PAF>

Arguments:
  <PAF>
          Input paf file

Options:
  -o, --output <OUTPUT>
          Output chain file

  -h, --help
          Print help (see a summary with '-h')
```


## transanno_liftvcf

### Tool Description
LiftOver VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
- **Homepage**: https://github.com/informationsea/transanno
- **Package**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Validation**: PASS

### Original Help Text
```text
LiftOver VCF file

Usage: transanno liftvcf [OPTIONS] --original-assembly <ORIGINAL_SEQUENCE> --new-assembly <NEW_SEQUENCE> --chain <CHAIN> --vcf <VCF> --output <OUTPUT> --fail <FAIL>

Options:
  -r, --original-assembly <ORIGINAL_SEQUENCE>
          Original assembly FASTA (.fai file is required)
  -q, --new-assembly <NEW_SEQUENCE>
          New assembly FASTA (.fai file is required)
  -c, --chain <CHAIN>
          chain file
  -v, --vcf <VCF>
          input VCF file to liftOver
  -o, --output <OUTPUT>
          output VCF file for succeeded to liftOver records (This file is not sorted)
  -f, --fail <FAIL>
          output VCF file for failed to liftOver records
  -m, --allow-multi-map
          Allow multi-map
  -d, --acceptable-deletion <ACCEPTABLE_DELETION>
          length of acceptable deletion [default: 3]
  -i, --acceptable-insertion <ACCEPTABLE_INSERTION>
          length of acceptable insertion [default: 3]
      --no-rewrite-format
          Do not rewrite order of FORMAT tags
      --no-rewrite-gt
          Do not rewrite order of GT
      --no-rewrite-allele-frequency
          Do not rewrite AF or other allele frequency info
      --no-rewrite-allele-count
          Do not rewrite AC or other count frequency info
      --noswap
          Do not swap ref/alt when reference allele is changed. This option is suitable to do liftOver clinVar, COSMIC annotations
      --no-left-align-chain
          Do not run left align chain file
      --do-not-use-dot-when-alt-equal-to-ref
          Do not use dot as ALT when ALT column is equal to REF
      --do-not-prefer-same-contig-when-multimap
          Do not prefer same name contig when a variant lifted into multiple positions. (When you use this option, a variant which lifted into a main chromosome and alternative contigs, lift over will be failed if multimap is not allowed)
      --ignore-fasta-length-mismatch
          Ignore length mismatch between chain and fasta file
  -h, --help
          Print help
```


## transanno_liftbed

### Tool Description
Lift BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
- **Homepage**: https://github.com/informationsea/transanno
- **Package**: https://anaconda.org/channels/bioconda/packages/transanno/overview
- **Validation**: PASS

### Original Help Text
```text
Lift BED file

Usage: transanno liftbed [OPTIONS] --chain <CHAIN> --output <OUTPUT> <BED>

Arguments:
  <BED>  input BED file

Options:
  -c, --chain <CHAIN>    chain file
  -o, --output <OUTPUT>  BED output path (unsorted)
  -f, --failed <FAILED>  Failed BED output path
  -m, --allow-multi-map  Allow multi-map
  -h, --help             Print help
```


## Metadata
- **Skill**: generated
