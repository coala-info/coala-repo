cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocaller
label: nanocaller
doc: "NanoCaller is a computational tool for variant calling (SNPs and Indels) from
  Oxford Nanopore and PacBio sequencing data using deep learning.\n\nTool homepage:
  https://github.com/WGLab/NanoCaller"
inputs:
  - id: bam
    type: File
    doc: Input BAM file, should be sorted and indexed
    inputBinding:
      position: 101
      prefix: -bam
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 101
      prefix: -cpu
  - id: max_cov
    type:
      - 'null'
      - int
    doc: Maximum coverage to call a variant
    inputBinding:
      position: 101
      prefix: --max_cov
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage to call a variant
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: preset
    type: string
    doc: "Sequencing technology preset: 'ont', 'clr', or 'hifi'"
    inputBinding:
      position: 101
      prefix: --preset
  - id: ref
    type: File
    doc: Reference genome FASTA file, should be indexed
    inputBinding:
      position: 101
      prefix: -ref
  - id: regions
    type:
      - 'null'
      - string
    doc: Limit calling to specific regions (e.g. chr1:100-200 or BED file)
    inputBinding:
      position: 101
      prefix: --regions
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name to be used in the VCF file
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocaller:3.6.2--h42286b9_0
