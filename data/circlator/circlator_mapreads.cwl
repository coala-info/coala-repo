cwlVersion: v1.2
class: CommandLineTool
baseCommand: circlator_mapreads
label: circlator_mapreads
doc: "Map reads using bwa mem\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: reference_fasta
    type: File
    doc: Name of input reference FASTA file
    inputBinding:
      position: 1
  - id: reads_fasta
    type: File
    doc: Name of corrected reads FASTA file
    inputBinding:
      position: 2
  - id: bwa_opts
    type:
      - 'null'
      - string
    doc: BWA options, in quotes
    inputBinding:
      position: 103
      prefix: --bwa_opts
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_bam
    type: File
    doc: Name of output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
