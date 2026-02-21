cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindthegap
label: mindthegap
doc: "MindTheGap is a software package for the detection and characterization of insertions
  in NGS data.\n\nTool homepage: https://github.com/GATB/mindthegap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindthegap:2.3.0--h5ca1c30_6
stdout: mindthegap.out
