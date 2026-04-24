cwlVersion: v1.2
class: CommandLineTool
baseCommand: parsec
label: galaxy-parsec_parsec
doc: "Command line wrappers around BioBlend functions. While this sounds unexciting,
  with parsec and jq you can easily build powerful command line scripts.\n\nTool homepage:
  https://github.com/galaxy-iuc/parsec"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: config_file_path
    type:
      - 'null'
      - File
    doc: config file path
    inputBinding:
      position: 103
      prefix: --path
  - id: galaxy_instance
    type: string
    doc: Name of instance in /root/.parsec.yml. This parameter can also be set 
      via the environment variable PARSEC_GALAXY_INSTANCE
    inputBinding:
      position: 103
      prefix: --galaxy_instance
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enables verbose mode.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-parsec:1.16.0--pyh5e36f6f_0
stdout: galaxy-parsec_parsec.out
