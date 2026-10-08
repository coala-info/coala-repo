cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - necat
  - config
label: necat_config
doc: "generate default config file\n\nUsage: necat.pl correct|assemble|bridge|config cfg_fname\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
inputs:
  - id: cfg_fname
    type: string
    doc: Name of the default config file to write
    inputBinding:
      position: 1
outputs:
  - id: config_file
    type: File
    doc: Default NECAT config file
    outputBinding:
      glob: $(inputs.cfg_fname)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
