cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi sub
label: fermi_sub
doc: "Usage: fermi sub [-c] [-t nThreads] <in.fmd> <array.bits>\n\nTool homepage:
  https://github.com/quantumlib/OpenFermion"
inputs:
  - id: in_fmd
    type: File
    doc: <in.fmd>
    inputBinding:
      position: 1
  - id: array_bits
    type: File
    doc: <array.bits>
    inputBinding:
      position: 2
  - id: compact
    type:
      - 'null'
      - boolean
    doc: compact
    inputBinding:
      position: 103
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: nThreads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_sub.out
