cwlVersion: v1.2
class: CommandLineTool
baseCommand: MindTheGap
label: mindthegap_MindTheGap
doc: "MindTheGap version 2.2.3\n\nTool homepage: https://github.com/GATB/mindthegap"
inputs:
  - id: module
    type: string
    doc: The module to run (find, fill)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindthegap:2.3.0--h5ca1c30_6
stdout: mindthegap_MindTheGap.out
