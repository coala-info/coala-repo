cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks combine
label: kmtricks_combine
doc: "Combine kmtricks's matrices (support kmer/hash matrices).\n\nTool homepage:
  https://github.com/tlemane/kmtricks"
inputs:
  - id: cpr
    type:
      - 'null'
      - boolean
    doc: compress output.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: fof
    type: File
    doc: input fof, one kmtricks run per line.
    inputBinding:
      position: 101
      prefix: --fof
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
