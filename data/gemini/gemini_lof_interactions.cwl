cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - lof_interactions
label: gemini_lof_interactions
doc: "Finds interactions for genes that harbor LoF variants.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried
    inputBinding:
      position: 1
  - id: edges
    type:
      - 'null'
      - File
    doc: "edges file (default is hprd). Format is geneA|geneB\ngeneA|geneC..."
    inputBinding:
      position: 102
      prefix: --edges
  - id: radius
    type:
      - 'null'
      - int
    doc: set filter for BFS
    inputBinding:
      position: 102
      prefix: -r
  - id: var
    type:
      - 'null'
      - boolean
    doc: "var mode: Returns variant info (e.g. impact, biotype) for\n            \
      \     interacting genes"
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
stdout: gemini_lof_interactions.out
