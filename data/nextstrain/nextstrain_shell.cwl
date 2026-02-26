cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nextstrain
  - shell
label: nextstrain_shell
doc: "Start a new shell inside the Nextstrain containerized build environment to run
  ad-hoc commands and perform debugging.\n\nTool homepage: https://nextstrain.org"
inputs:
  - id: directory
    type: Directory
    doc: Path to pathogen build directory
    inputBinding:
      position: 1
  - id: additional_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to the executed program
    inputBinding:
      position: 2
  - id: help_all
    type:
      - 'null'
      - boolean
    doc: Show a full help message of all options and exit
    inputBinding:
      position: 103
      prefix: --help-all
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
stdout: nextstrain_shell.out
