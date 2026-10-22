cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - positional-tracks
label: slamdunk_alleyoop_positional-tracks
doc: "Genome-wide positional tracks as bedgraph\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: 'Bam file(s)'
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 100
  - id: reference
    type: File
    doc: 'Reference fasta file'
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --reference
  - id: snp_directory
    type: ['null', Directory]
    doc: 'Directory containing SNP files.'
    inputBinding:
      position: 1
      prefix: --snp-directory
  - id: vcf_file
    type: ['null', File]
    doc: 'Skip SNP step and provide custom variant file.'
    inputBinding:
      position: 1
      prefix: --vcf
  - id: conversion_threshold
    type: ['null', int]
    doc: 'Number of T>C conversions required to count read as T>C read (default: 1)'
    inputBinding:
      position: 1
      prefix: --conversion-threshold
  - id: coverage_cutoff
    type: ['null', int]
    doc: 'Minimum coverage required to report nucleotide-conversion rate (default: 1). Anything less than 1 will be set to 1 to avoid division by zero.'
    inputBinding:
      position: 1
      prefix: --coverage-cutoff
  - id: min_base_qual
    type: ['null', int]
    doc: 'Min base quality for T -> C conversions (default: 27)'
    inputBinding:
      position: 1
      prefix: --min-base-qual
  - id: threads
    type: ['null', int]
    doc: 'Thread number (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: output_dir
    type: string
    default: positional_tracks_out
    doc: Output directory
    inputBinding:
      position: 1
      prefix: --outputDir
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
