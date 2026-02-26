cwlVersion: v1.2
class: CommandLineTool
baseCommand: necat.pl
label: necat_correct
doc: "necat.pl correct|assemble|bridge|config cfg_fname\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run: correct, assemble, bridge, or config'
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
stdout: necat_correct.out
