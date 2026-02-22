cwlVersion: v1.2
class: CommandLineTool
baseCommand: flams
label: flams
doc: "Fast Local Alignment of Multiple Sequences (FLAMS) is a tool for searching and
  aligning protein sequences against a database.\n\nTool homepage: https://github.com/hannelorelongin/FLAMS"
inputs:
  - id: query
    type: File
    doc: Input query protein sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: database
    type: File
    doc: Target database file
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for alignment results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flams:1.1.7--pyhdfd78af_0
