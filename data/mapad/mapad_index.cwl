cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapad_index
label: mapad_index
doc: "Indexes a genome file\n\nTool homepage: https://github.com/mpieva/mapAD"
inputs:
  - id: port
    type:
      - 'null'
      - int
    doc: TCP port to communicate over
    default: 3130
    inputBinding:
      position: 101
      prefix: --port
  - id: reference
    type: File
    doc: FASTA file containing the genome to be indexed
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator
    default: 1234
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads. If 0, mapAD will select the number of 
      threads automatically.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Sets the level of verbosity
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
stdout: mapad_index.out
