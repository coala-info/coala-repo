cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsplotdb.py
label: ngsplotdb-ngsplotdb-hg19_ngsplotdb.py
doc: "Manipulate ngs.plot's annotation database\n\nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Say yes to all prompted questions
    inputBinding:
      position: 103
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
stdout: ngsplotdb-ngsplotdb-hg19_ngsplotdb.py.out
