cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hpcrunner.pl
  - new
label: perl-hpc-runner-command_new
doc: "This creates a new project, initializes git and directory structure\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TZ
        envValue: UTC
inputs:
  - id: plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: "Load application plugins (comma separated)"
    inputBinding:
      position: 101
      prefix: --plugins
      itemSeparator: ','
  - id: plugins_opts
    type:
      - 'null'
      - string
    doc: "Options for application plugins [Key-Value]"
    inputBinding:
      position: 101
      prefix: --plugins_opts
  - id: config_base
    type:
      - 'null'
      - string
    doc: "Basename of config files [Default:\".hpcrunner\"]"
    inputBinding:
      position: 101
      prefix: --config_base
  - id: search_path
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --search_path
    doc: "Enable a search path for configs; default is the home dir and your cwd"
    inputBinding:
      position: 101
  - id: no_configs
    type:
      - 'null'
      - boolean
    doc: "Tell HPC::Runner not to load any configs"
    inputBinding:
      position: 101
      prefix: --no_configs
  - id: config
    type:
      - 'null'
      - File
    doc: "Override the search paths and supply your own config"
    inputBinding:
      position: 101
      prefix: --config
  - id: search
    type:
      - 'null'
      - boolean
    doc: "Search for config files in ~/.config.(ext) and in your current working directory"
    inputBinding:
      position: 101
      prefix: --search
  - id: no_log_json
    type:
      - 'null'
      - boolean
    doc: "Opt out of writing the tar archive of JSON stats"
    inputBinding:
      position: 101
      prefix: --no_log_json
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Turn off log messages written to STDOUT"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: log
    type:
      - 'null'
      - string
    doc: "Path to file used for logging"
    inputBinding:
      position: 101
      prefix: --log
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Turn on debug mode"
    inputBinding:
      position: 101
      prefix: --debug
  - id: project
    type: string
    doc: "Project name for your analysis project"
    inputBinding:
      position: 101
      prefix: --project
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: project_dir
    type: Directory
    doc: New project directory
    outputBinding:
      glob: $(inputs.project)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command_new.out
