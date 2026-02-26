cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools_map2cov
label: blobtools_map2cov
doc: "Map BAM/CAS files to a FASTA assembly to calculate coverage.\n\nTool homepage:
  https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM file (requires pysam)
    inputBinding:
      position: 101
      prefix: --bam
  - id: calculate_cov
    type:
      - 'null'
      - boolean
    doc: Legacy coverage, slower. New default is to estimate coverages based on 
      read lengths of first 10K reads.
    inputBinding:
      position: 101
      prefix: --calculate_cov
  - id: cas
    type:
      - 'null'
      - type: array
        items: File
    doc: CAS file (requires clc_mapping_info in $PATH)
    inputBinding:
      position: 101
      prefix: --cas
  - id: infile
    type: File
    doc: FASTA file of assembly. Headers are split at whitespaces.
    inputBinding:
      position: 101
      prefix: --infile
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_map2cov.out
