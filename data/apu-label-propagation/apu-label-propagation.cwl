cwlVersion: v1.2
class: CommandLineTool
baseCommand: apu-label-propagation
label: apu-label-propagation
doc: "A tool for label propagation analysis.\n\nTool homepage: https://github.com/AndMastro/NIAPU"
inputs:
  - id: file_in
    type: File
    doc: Input file for label propagation
    inputBinding:
      position: 1
  - id: flag_header
    type: string
    doc: Flag indicating header presence or configuration
    inputBinding:
      position: 2
  - id: s_quantile
    type: float
    doc: S quantile value
    inputBinding:
      position: 3
  - id: rn_quantile
    type: float
    doc: RN quantile value
    inputBinding:
      position: 4
outputs:
  - id: file_out
    type: File
    doc: Output file for results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apu-label-propagation:1.2--h7b50bb2_3
