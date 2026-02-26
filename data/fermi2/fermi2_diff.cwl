cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2_diff
label: fermi2_diff
doc: "Compares two rld files.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: query_rld
    type: File
    doc: Query rld file
    inputBinding:
      position: 1
  - id: ref_rld
    type: File
    doc: Reference rld file
    inputBinding:
      position: 2
  - id: maxK
    type:
      - 'null'
      - int
    doc: Maximum k-mer size
    default: 51
    inputBinding:
      position: 103
      prefix: -K
  - id: minK
    type:
      - 'null'
      - int
    doc: Minimum k-mer size
    default: 25
    inputBinding:
      position: 103
      prefix: -k
  - id: minOcc
    type:
      - 'null'
      - int
    doc: Minimum occurrence of a k-mer
    default: 2
    inputBinding:
      position: 103
      prefix: -o
  - id: nThreads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_diff.out
