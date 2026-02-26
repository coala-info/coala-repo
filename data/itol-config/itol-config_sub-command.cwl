cwlVersion: v1.2
class: CommandLineTool
baseCommand: itol_config
label: itol-config_sub-command
doc: "Configuration tool for ITOL\n\nTool homepage: https://github.com/jodyphelan/itol-config"
inputs:
  - id: sub_command
    type: string
    doc: The sub-command to run (colour_strip, text_label, binary_data)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
stdout: itol-config_sub-command.out
