cwlVersion: v1.2
class: CommandLineTool
baseCommand: wb_command
label: connectome-workbench_wb_command
doc: "Connectome Workbench command-line interface\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: all_commands_help
    type:
      - 'null'
      - boolean
    doc: show all processing subcommands and their help info - VERY LONG
    inputBinding:
      position: 101
      prefix: -all-commands-help
  - id: arguments_help
    type:
      - 'null'
      - boolean
    doc: explain the format of subcommand help info
    inputBinding:
      position: 101
      prefix: -arguments-help
  - id: cifti_help
    type:
      - 'null'
      - boolean
    doc: explain the cifti file format and related terms
    inputBinding:
      position: 101
      prefix: -cifti-help
  - id: gifti_help
    type:
      - 'null'
      - boolean
    doc: explain the gifti file format (metric, surface)
    inputBinding:
      position: 101
      prefix: -gifti-help
  - id: global_options
    type:
      - 'null'
      - boolean
    doc: display options that can be added to any command
    inputBinding:
      position: 101
      prefix: -global-options
  - id: list_commands
    type:
      - 'null'
      - boolean
    doc: list all processing subcommands
    inputBinding:
      position: 101
      prefix: -list-commands
  - id: list_deprecated_commands
    type:
      - 'null'
      - boolean
    doc: list deprecated subcommands
    inputBinding:
      position: 101
      prefix: -list-deprecated-commands
  - id: parallel_help
    type:
      - 'null'
      - boolean
    doc: details on how wb_command uses parallelization
    inputBinding:
      position: 101
      prefix: -parallel-help
  - id: volume_help
    type:
      - 'null'
      - boolean
    doc: explain volume files, including label volumes
    inputBinding:
      position: 101
      prefix: -volume-help
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
stdout: connectome-workbench_wb_command.out
