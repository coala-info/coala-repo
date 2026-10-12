cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hpcrunner.pl
  - stats
label: perl-hpc-runner-command_stats
doc: "Query submissions by project, or jobname. This searches through the tars created during execution\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TZ
        envValue: UTC
inputs:
  - id: stats_type
    type:
      - 'null'
      - string
    doc: "JSON, Sqlite or Elasticsearch [Default:JSON]"
    inputBinding:
      position: 1
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
  - id: project
    type:
      - 'null'
      - string
    doc: "Query by project"
    inputBinding:
      position: 101
      prefix: --project
  - id: no_log_json
    type:
      - 'null'
      - boolean
    doc: "Opt out of writing the tar archive of JSON stats"
    inputBinding:
      position: 101
      prefix: --no_log_json
  - id: data_dir
    type:
      - 'null'
      - string
    doc: "Data directory for hpcrunner"
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: data_tar
    type:
      - 'null'
      - File
    doc: "Submission tar to query"
    inputBinding:
      position: 101
      prefix: --data_tar
  - id: most_recent
    type:
      - 'null'
      - boolean
    doc: "Show only the most recent submission"
    inputBinding:
      position: 101
      prefix: --most_recent
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Show all submissions"
    inputBinding:
      position: 101
      prefix: --all
  - id: jobname
    type:
      - 'null'
      - string
    doc: "Query by jobname"
    inputBinding:
      position: 101
      prefix: --jobname
  - id: summary
    type:
      - 'null'
      - boolean
    doc: "Summary view of your jobs - Number of running, completed, failed, successful"
    inputBinding:
      position: 101
      prefix: --summary
  - id: long
    type:
      - 'null'
      - boolean
    doc: "Long view. More detailed report - Task tags, exit codes, duration, etc."
    inputBinding:
      position: 101
      prefix: --long
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Output data in json instead of a table"
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command_stats.out
