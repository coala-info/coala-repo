cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2 occflt
label: fermi2_occflt
doc: "Filter reads based on occurrence count.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: query_rld
    type: File
    doc: Input query.rld file
    inputBinding:
      position: 1
  - id: maxK
    type:
      - 'null'
      - int
    doc: Maximum K-mer size
    default: 51
    inputBinding:
      position: 102
      prefix: -K
  - id: minK
    type:
      - 'null'
      - int
    doc: Minimum K-mer size
    default: 25
    inputBinding:
      position: 102
      prefix: -k
  - id: minOcc
    type:
      - 'null'
      - int
    doc: Minimum occurrence count
    default: 2
    inputBinding:
      position: 102
      prefix: -o
  - id: nThreads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_occflt.out
