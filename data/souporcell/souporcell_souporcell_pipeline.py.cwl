cwlVersion: v1.2
class: CommandLineTool
baseCommand: souporcell_pipeline.py
label: souporcell_souporcell_pipeline.py
doc: "single cell RNAseq mixed genotype clustering using sparse mixture model clustering.\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: bam
    type: File
    doc: "cellranger bam"
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '^.bai'
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcodes
    type: File
    doc: "barcodes.tsv from cellranger"
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: fasta
    type: File
    doc: "reference fasta file"
    secondaryFiles:
      - pattern: '.fai'
        required: false
    inputBinding:
      position: 101
      prefix: --fasta
  - id: threads
    type: int
    doc: "max threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_dir
    type: string
    doc: "name of directory to place souporcell files"
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: clusters
    type: int
    doc: "number cluster, tbd add easy way to run on a range of k"
    inputBinding:
      position: 101
      prefix: --clusters
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "ploidy, must be 1 or 2, default = 2"
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: min_alt
    type:
      - 'null'
      - int
    doc: "min alt to use locus, default = 10."
    inputBinding:
      position: 101
      prefix: --min_alt
  - id: min_ref
    type:
      - 'null'
      - int
    doc: "min ref to use locus, default = 10."
    inputBinding:
      position: 101
      prefix: --min_ref
  - id: max_loci
    type:
      - 'null'
      - int
    doc: "max loci per cell, affects speed, default = 2048."
    inputBinding:
      position: 101
      prefix: --max_loci
  - id: restarts
    type:
      - 'null'
      - int
    doc: "number of restarts in clustering, when there are > 12 clusters we recommend increasing this to avoid local minima"
    inputBinding:
      position: 101
      prefix: --restarts
  - id: common_variants
    type:
      - 'null'
      - File
    doc: "common variant loci or known variant loci vcf, must be vs same reference fasta"
    inputBinding:
      position: 101
      prefix: --common_variants
  - id: known_genotypes
    type:
      - 'null'
      - File
    doc: "known variants per clone in population vcf mode, must be .vcf right now we dont accept gzip or bcf sorry"
    inputBinding:
      position: 101
      prefix: --known_genotypes
  - id: known_genotypes_sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "which samples in population vcf from known genotypes option represent the donors in your sample"
    inputBinding:
      position: 101
      prefix: --known_genotypes_sample_names
  - id: skip_remap
    type:
      - 'null'
      - string
    doc: "don't remap with minimap2 (not recommended unless in conjunction with --common_variants); any non-empty value switches it on"
    inputBinding:
      position: 101
      prefix: --skip_remap
  - id: no_umi
    type:
      - 'null'
      - string
    doc: "set to True if your bam has no UMI tag, will ignore/override --umi_tag"
    inputBinding:
      position: 101
      prefix: --no_umi
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: "set if your umi tag is not UB"
    inputBinding:
      position: 101
      prefix: --umi_tag
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: "set if your cell barcode tag is not CB"
    inputBinding:
      position: 101
      prefix: --cell_tag
  - id: ignore
    type:
      - 'null'
      - string
    doc: "set to True to ignore data error assertions; any non-empty value switches it on"
    inputBinding:
      position: 101
      prefix: --ignore
  - id: aligner
    type:
      - 'null'
      - string
    doc: "optionally change to HISAT2 if you have it installed, not included in singularity build"
    inputBinding:
      position: 101
      prefix: --aligner
outputs:
  - id: out_dir_output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
