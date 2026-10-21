cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bgenFileInfo]
label: rvtests_bgenFileInfo
doc: "Display file information of one BGEN input file.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: in_bgen
    type: File
    doc: "Input BGEN File"
    inputBinding:
      position: 101
      prefix: --inBgen
  - id: in_sample
    type:
      - 'null'
      - File
    doc: "Input Sample File"
    inputBinding:
      position: 101
      prefix: --inSample
outputs:
  - id: info
    type: stdout
    doc: "BGEN header, sample identifiers and variant block summary"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: $(inputs.in_bgen.basename).info.txt
