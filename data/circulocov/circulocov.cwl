cwlVersion: v1.2
class: CommandLineTool
baseCommand: circulocov
label: circulocov
doc: "Calculate coverage for circular genomes.\n\nTool homepage: https://github.com/erinyoung/CirculoCov"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Include all sequences
    inputBinding:
      position: 101
      prefix: --all
  - id: genome
    type: File
    doc: Genome (draft or complete)
    inputBinding:
      position: 101
      prefix: --genome
  - id: illumina
    type:
      - 'null'
      - type: array
        items: File
    doc: Input illumina fastq(s)
    inputBinding:
      position: 101
      prefix: --illumina
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: nanopore
    type:
      - 'null'
      - File
    doc: Input nanopore fastq
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: no_all
    type:
      - 'null'
      - boolean
    doc: Do not include all sequences
    inputBinding:
      position: 101
      prefix: --no-all
  - id: pacbio
    type:
      - 'null'
      - File
    doc: Input pacbio fastq
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: padding
    type:
      - 'null'
      - int
    doc: Amount of padding added to circular sequences
    inputBinding:
      position: 101
      prefix: --padding
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: Number of windows for coverage
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Result directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circulocov:0.1.20240104--pyhdfd78af_0
