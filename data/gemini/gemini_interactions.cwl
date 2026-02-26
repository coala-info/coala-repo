cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini interactions
label: gemini_interactions
doc: "Query gemini database for interactions\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried
    inputBinding:
      position: 1
  - id: edges
    type:
      - 'null'
      - string
    doc: edges file (default is hprd). Format is geneA|geneB geneA|geneC...
    default: hprd
    inputBinding:
      position: 102
      prefix: --edges
  - id: gene
    type:
      - 'null'
      - string
    doc: Gene to be used as a root in BFS/shortest_path
    inputBinding:
      position: 102
      prefix: --gene
  - id: radius
    type:
      - 'null'
      - string
    doc: 'Set filter for BFS: valid numbers starting from 0'
    inputBinding:
      position: 102
      prefix: --radius
  - id: var
    type:
      - 'null'
      - boolean
    doc: 'var mode: Returns variant info (e.g. impact, biotype) for interacting genes'
    inputBinding:
      position: 102
      prefix: --var
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_interactions.out
