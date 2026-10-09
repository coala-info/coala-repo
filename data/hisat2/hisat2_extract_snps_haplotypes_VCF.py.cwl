cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_snps_haplotypes_VCF.py
label: hisat2_extract_snps_haplotypes_VCF.py
doc: "Extract SNPs and haplotypes from VCF files\n\nTool homepage: https://daehwankimlab.github.io/hisat2"
inputs:
  - id: genome_file
    type: File
    doc: input genome file (e.g. genome.fa)
    inputBinding:
      position: 1
  - id: vcf_files
    type:
      type: array
      items: File
    doc: Comma-separated VCF files (plain text or gzipped)
    inputBinding:
      position: 2
      itemSeparator: ','
  - id: base_fname
    type: string
    doc: base filename for SNPs and haplotypes
    inputBinding:
      position: 3
  - id: reference_type
    type:
      - 'null'
      - string
    doc: 'Reference type: gene, chromosome, and genome (default: genome)'
    inputBinding:
      position: 0
      prefix: --reference-type
  - id: inter_gap
    type:
      - 'null'
      - int
    doc: 'Maximum distance for variants to be in the same haplotype (default: 30)'
    inputBinding:
      position: 0
      prefix: --inter-gap
  - id: intra_gap
    type:
      - 'null'
      - int
    doc: 'Break a haplotype into several haplotypes (default: 50)'
    inputBinding:
      position: 0
      prefix: --intra-gap
  - id: non_rs
    type:
      - 'null'
      - boolean
    doc: Allow SNP IDs not beginning with rs
    inputBinding:
      position: 0
      prefix: --non-rs
  - id: genotype_vcf
    type:
      - 'null'
      - File
    doc: 'VCF file name for genotyping (default: empty)'
    inputBinding:
      position: 0
      prefix: --genotype-vcf
  - id: genotype_gene_list
    type:
      - 'null'
      - string
    doc: 'A comma-separated list of genes to be genotyped (default: empty)'
    inputBinding:
      position: 0
      prefix: --genotype-gene-list
  - id: extra_files
    type:
      - 'null'
      - boolean
    doc: Output extra files such as _backbone.fa and .ref
    inputBinding:
      position: 0
      prefix: --extra-files
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: also print some statistics to stderr
    inputBinding:
      position: 0
      prefix: --verbose
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: SNP and haplotype files written with the base filename
    outputBinding:
      glob: $(inputs.base_fname)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
