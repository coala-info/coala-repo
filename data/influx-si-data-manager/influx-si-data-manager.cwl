cwlVersion: v1.2
class: CommandLineTool
baseCommand: influx-si-data-manager
label: influx-si-data-manager
doc: "A tool for managing data within the Influx-SI workflow.\n\nTool homepage: https://github.com/llegregam/influx_data_manager"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/influx-si-data-manager:1.1.1--pyhdfd78af_0
stdout: influx-si-data-manager.out
