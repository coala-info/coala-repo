cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk_count
label: slamdunk_count
doc: "Count T>C conversions in BAM files.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Bam file(s)
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: BED file
    inputBinding:
      position: 102
      prefix: --bed
  - id: conversion_threshold
    type:
      - 'null'
      - int
    doc: Number of T>C conversions required to count read as T>C read
    default: 1
    inputBinding:
      position: 102
      prefix: --conversion-threshold
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Max read length in BAM file
    inputBinding:
      position: 102
      prefix: --max-read-length
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: Min base quality for T -> C conversions
    default: 27
    inputBinding:
      position: 102
      prefix: --min-base-qual
  - id: reference
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: snp_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing SNP files.
    inputBinding:
      position: 102
      prefix: --snp-directory
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Externally provided custom variant file.
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for mapped BAM files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
