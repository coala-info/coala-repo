cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyplas
label: hyplas
doc: "Hyplas is a tool for plasmid assembly and analysis.\n\nTool homepage: https://github.com/cchauve/hyplas"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of output files
    inputBinding:
      position: 101
      prefix: --force
  - id: long_reads
    type:
      - 'null'
      - File
    doc: long reads fastq file
    inputBinding:
      position: 101
      prefix: --long-reads
  - id: platon_db
    type: string
    doc: Platon database path
    inputBinding:
      position: 101
      prefix: --platon-db
  - id: propagate_rounds
    type:
      - 'null'
      - int
    doc: Number of rounds to propagate plasmid long read information
    inputBinding:
      position: 101
      prefix: --propagate-rounds
  - id: short_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: short reads fastq files
    inputBinding:
      position: 101
      prefix: --short-reads
  - id: sr_assembly
    type:
      - 'null'
      - File
    doc: short reads assembly graph
    inputBinding:
      position: 101
      prefix: --sr-assembly
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Logging verbosity level
    default: INFO
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyplas:1.0.2--py311h2de2dd3_0
