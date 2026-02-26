cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini pathways
label: gemini_pathways
doc: "Report pathways for indivs/genes/sites with LoF variants\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried
    inputBinding:
      position: 1
  - id: lof
    type:
      - 'null'
      - boolean
    doc: Report pathways for indivs/genes/sites with LoF variants
    inputBinding:
      position: 102
      prefix: --lof
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_pathways.out
