cwlVersion: v1.2
class: CommandLineTool
baseCommand: biox
label: perl-biox-workflow-command_biox
doc: "BioX::Workflow::Command is a templating system for creating Bioinformatics Workflows.\n
  \nTool homepage: https://github.com/biosails/BioX-Workflow-Command"
inputs:
  - id: command
    type: string
    doc: The command to execute (add, inspect, new, run, stats, validate, help)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Override the search paths and supply your own config.
    inputBinding:
      position: 102
      prefix: --config
  - id: config_base
    type:
      - 'null'
      - string
    doc: Basename of config files
    default: .bioxworkflow
    inputBinding:
      position: 102
      prefix: --config_base
  - id: no_configs
    type:
      - 'null'
      - boolean
    doc: --no_configs tells HPC::Runner not to load any configs
    inputBinding:
      position: 102
      prefix: --no_configs
  - id: plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: Load aplication plugins [Multiple; Split by ","]
    inputBinding:
      position: 102
      prefix: --plugins
  - id: plugins_opts
    type:
      - 'null'
      - string
    doc: Options for application plugins [Key-Value]
    inputBinding:
      position: 102
      prefix: --plugins_opts
  - id: search
    type:
      - 'null'
      - boolean
    doc: Search for config files in ~/.config.(ext) and in your current working directory.
    inputBinding:
      position: 102
      prefix: --search
  - id: search_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Enable a search path for configs. Default is the home dir and your cwd.
    inputBinding:
      position: 102
      prefix: --search_path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biox-workflow-command:2.4.1--pl5.22.0_0
stdout: perl-biox-workflow-command_biox.out
