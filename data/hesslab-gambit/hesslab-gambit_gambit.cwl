cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: hesslab-gambit_gambit
doc: "Tool for rapid taxonomic identification of microbial pathogens from genomic
  data.\n\nTool homepage: https://github.com/hesslab-gambit/gambit"
inputs:
  - id: command
    type: string
    doc: Command to execute (dist, query, signatures)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files.
    inputBinding:
      position: 103
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit_gambit.out
