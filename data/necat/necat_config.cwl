cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - necat.pl
  - config
label: necat_config
doc: "generate default config file\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs:
  - id: cfg_fname
    type: string
    doc: Configuration file name
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
stdout: necat_config.out
