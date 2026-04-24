cwlVersion: v1.2
class: CommandLineTool
baseCommand: moni build
label: moni_build
doc: "Builds a reference index for the moni tool.\n\nTool homepage: https://github.com/maxrossi91/moni"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress output of the parsing phase (debug only)
    inputBinding:
      position: 101
      prefix: --compress
  - id: grammar
    type:
      - 'null'
      - string
    doc: select the grammar [plain, shaped]
    inputBinding:
      position: 101
      prefix: --grammar
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: keep temporary files
    inputBinding:
      position: 101
      prefix: -k
  - id: mod
    type:
      - 'null'
      - int
    doc: hash modulus
    inputBinding:
      position: 101
      prefix: --mod
  - id: parsing
    type:
      - 'null'
      - boolean
    doc: stop after the parsing phase (debug only)
    inputBinding:
      position: 101
      prefix: --parsing
  - id: read_fasta
    type:
      - 'null'
      - boolean
    doc: read fasta
    inputBinding:
      position: 101
      prefix: -f
  - id: reference
    type: File
    doc: reference file name
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: number of helper threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 101
      prefix: -v
  - id: wsize
    type:
      - 'null'
      - int
    doc: sliding window size
    inputBinding:
      position: 101
      prefix: --wsize
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: output directory path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
