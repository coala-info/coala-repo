cwlVersion: v1.2
class: CommandLineTool
baseCommand: git
label: julia_git
doc: "These are common Git commands used in various situations:\n\nTool homepage:
  https://github.com/JuliaLang/julia"
inputs:
  - id: command
    type: string
    doc: The Git command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the Git command
    inputBinding:
      position: 2
  - id: bare
    type:
      - 'null'
      - boolean
    doc: Create a bare repository
    inputBinding:
      position: 103
      prefix: --bare
  - id: config
    type:
      - 'null'
      - string
    doc: Set a Git configuration variable
    inputBinding:
      position: 103
      prefix: -c
  - id: config_env
    type:
      - 'null'
      - string
    doc: Specify a configuration variable from an environment variable
    inputBinding:
      position: 103
      prefix: --config-env
  - id: exec_path
    type:
      - 'null'
      - Directory
    doc: Specify the Git executable path
    inputBinding:
      position: 103
      prefix: --exec-path
  - id: git_dir
    type:
      - 'null'
      - Directory
    doc: Specify the Git repository directory
    inputBinding:
      position: 103
      prefix: --git-dir
  - id: html_path
    type:
      - 'null'
      - boolean
    doc: Show HTML documentation path
    inputBinding:
      position: 103
      prefix: --html-path
  - id: info_path
    type:
      - 'null'
      - boolean
    doc: Show info documentation path
    inputBinding:
      position: 103
      prefix: --info-path
  - id: man_path
    type:
      - 'null'
      - boolean
    doc: Show man page path
    inputBinding:
      position: 103
      prefix: --man-path
  - id: namespace
    type:
      - 'null'
      - string
    doc: Specify the namespace
    inputBinding:
      position: 103
      prefix: --namespace
  - id: no_advice
    type:
      - 'null'
      - boolean
    doc: Do not show advice
    inputBinding:
      position: 103
      prefix: --no-advice
  - id: no_lazy_fetch
    type:
      - 'null'
      - boolean
    doc: Do not perform lazy fetches
    inputBinding:
      position: 103
      prefix: --no-lazy-fetch
  - id: no_optional_locks
    type:
      - 'null'
      - boolean
    doc: Do not use optional locks
    inputBinding:
      position: 103
      prefix: --no-optional-locks
  - id: no_pager
    type:
      - 'null'
      - boolean
    doc: Do not use a pager for output
    inputBinding:
      position: 103
      prefix: --no-pager
  - id: no_replace_objects
    type:
      - 'null'
      - boolean
    doc: Do not use replace objects
    inputBinding:
      position: 103
      prefix: --no-replace-objects
  - id: paginate
    type:
      - 'null'
      - boolean
    doc: Use a pager for output
    inputBinding:
      position: 103
      prefix: --paginate
  - id: path
    type:
      - 'null'
      - Directory
    doc: Change to directory before running command
    inputBinding:
      position: 103
      prefix: -C
  - id: work_tree
    type:
      - 'null'
      - Directory
    doc: Specify the working tree path
    inputBinding:
      position: 103
      prefix: --work-tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/julia:1.10
stdout: julia_git.out
