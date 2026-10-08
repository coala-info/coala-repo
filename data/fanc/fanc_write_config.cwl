cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - write-config
label: fanc_write_config
doc: "Write the default FAN-C config file to a location.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: config_file
    type: string
    default: fanc.conf
    doc: "Output file for default configuration."
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwrite of existing config file."
    inputBinding:
      position: 20
      prefix: --force
outputs:
  - id: config
    type: File
    doc: "Default FAN-C configuration file."
    outputBinding:
      glob: $(inputs.config_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
