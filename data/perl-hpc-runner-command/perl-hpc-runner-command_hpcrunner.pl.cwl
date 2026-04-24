cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hpc-runner-command_hpcrunner.pl
label: perl-hpc-runner-command_hpcrunner.pl
doc: "HPC::Runner::Command is a set of libraries for scaffolding data analysis projects,
  submitting and executing jobs on an HPC cluster or workstation, and obsessively
  logging results.\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Override the search paths and supply your own config.
    inputBinding:
      position: 101
      prefix: --config
  - id: config_base
    type:
      - 'null'
      - string
    doc: Basename of config files [Default:".hpcrunner"]
    inputBinding:
      position: 101
      prefix: --config_base
  - id: no_configs
    type:
      - 'null'
      - boolean
    doc: --no_configs tells HPC::Runner not to load any configs [Flag]
    inputBinding:
      position: 101
      prefix: --no_configs
  - id: no_log_json
    type:
      - 'null'
      - boolean
    doc: Opt out of writing the tar archive of JSON stats. This may be desirable
      for especially large workflows. [Flag]
    inputBinding:
      position: 101
      prefix: --no_log_json
  - id: plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: Load aplication plugins [Multiple; Split by ","]
    inputBinding:
      position: 101
      prefix: --plugins
  - id: plugins_opts
    type:
      - 'null'
      - string
    doc: Options for application plugins [Key-Value]
    inputBinding:
      position: 101
      prefix: --plugins_opts
  - id: project
    type:
      - 'null'
      - string
    doc: 'Give your jobnames an additional project name. #HPC jobname=gzip will be
      submitted as 001_project_gzip'
    inputBinding:
      position: 101
      prefix: --project
  - id: search
    type:
      - 'null'
      - boolean
    doc: Search for config files in ~/.config.(ext) and in your current working 
      directory. [Flag]
    inputBinding:
      position: 101
      prefix: --search
  - id: search_path
    type:
      - 'null'
      - type: array
        items: string
    doc: Enable a search path for configs. Default is the home dir and your cwd.
      [Multiple]
    inputBinding:
      position: 101
      prefix: --search_path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command_hpcrunner.pl.out
