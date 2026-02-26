cwlVersion: v1.2
class: CommandLineTool
baseCommand: ragtag.py
label: ragtag_ragtag.py
doc: "RagTag: Tools for fast and flexible genome assembly scaffolding and improvement.\n\
  \nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: command
    type: string
    doc: Command to run (correct, scaffold, patch, merge, agp2fa, agpcheck, 
      asmstats, splitasm, delta2paf, paf2delta, updategff)
    inputBinding:
      position: 1
  - id: citation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --citation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_ragtag.py.out
