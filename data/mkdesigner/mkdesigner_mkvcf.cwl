cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkvcf
label: mkdesigner_mkvcf
doc: "MKDesigner version 0.5.3\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: "Bam files for variant calling.\ne.g. -b bam1 -b bam2 ... \nYou must use
      this option 2 times or more\nto get markers in following analysis."
    inputBinding:
      position: 101
      prefix: --bam
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: output_stem
    type: string
    doc: "Identical name (must be unique).\nThis will be stem of output directory
      name."
    inputBinding:
      position: 101
      prefix: --output
  - id: reference_fasta
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 101
      prefix: --ref
  - id: variety_names
    type:
      type: array
      items: string
    doc: "Variety name of each bam file.\ne.g. -n name_bam1 -n name_bam2 ... \nYou
      must use this option same times\nas -b."
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.3--pyhdfd78af_0
stdout: mkdesigner_mkvcf.out
