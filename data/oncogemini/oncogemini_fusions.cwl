cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini fusions
label: oncogemini_fusions
doc: "Query the database for fusions.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
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
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_fusions.out
