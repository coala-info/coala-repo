cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm2
label: checkm2_directory
doc: "checkm2: error: argument subparser_name: invalid choice: 'directory' (choose
  from predict, testrun, database)\n\nTool homepage: https://github.com/chklovski/CheckM2"
inputs:
  - id: subparser_name
    type: string
    doc: choose from predict, testrun, database
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: lowmem
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --lowmem
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
stdout: checkm2_directory.out
