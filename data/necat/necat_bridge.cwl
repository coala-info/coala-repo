cwlVersion: v1.2
class: CommandLineTool
baseCommand: necat.pl bridge
label: necat_bridge
doc: "bridge contigs\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs:
  - id: cfg_fname
    type: string
    doc: config file name
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
stdout: necat_bridge.out
