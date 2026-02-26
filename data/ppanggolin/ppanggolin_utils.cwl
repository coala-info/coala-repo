cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - utils
label: ppanggolin_utils
doc: "Generate a config file with default values for the given subcommand.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: default_config
    type: string
    doc: Generate a config file with default values for the given subcommand.
    inputBinding:
      position: 101
      prefix: --default_config
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the given output file if it exists.
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: output
    type:
      - 'null'
      - File
    doc: name and path of the config file with default parameters written in 
      yaml.
    inputBinding:
      position: 101
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin_utils.out
