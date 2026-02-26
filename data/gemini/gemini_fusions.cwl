cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - fusions
label: gemini_fusions
doc: "Query the database for fusion events.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: evidence_type
    type:
      - 'null'
      - string
    doc: The supporting evidence types for the variant ("PE", "SR", or "PE,SR")
    inputBinding:
      position: 102
      prefix: --evidence_type
  - id: in_cosmic_census
    type:
      - 'null'
      - boolean
    doc: One or both genes in fusion is in COSMIC cancer census
    inputBinding:
      position: 102
      prefix: --in_cosmic_census
  - id: min_qual
    type:
      - 'null'
      - float
    doc: The min variant quality (VCF QUAL)
    default: None
    inputBinding:
      position: 102
      prefix: --min_qual
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_fusions.out
