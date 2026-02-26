cwlVersion: v1.2
class: CommandLineTool
baseCommand: necat.pl
label: necat_assemble
doc: "NECAT is a tool for assembling long reads.\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs:
  - id: command
    type: string
    doc: 'Command to execute: correct, assemble, bridge, or config'
    inputBinding:
      position: 1
  - id: cfg_fname
    type: string
    doc: Configuration file name
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
stdout: necat_assemble.out
