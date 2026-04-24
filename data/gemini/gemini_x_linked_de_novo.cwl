cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini x_linked_de_novo
label: gemini_x_linked_de_novo
doc: "Find X-linked de novo variants\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: allow_unaffected
    type:
      - 'null'
      - boolean
    doc: Report candidates that also impact samples labeled as unaffected.
    inputBinding:
      position: 102
      prefix: --allow-unaffected
  - id: columns
    type:
      - 'null'
      - string
    doc: A list of columns that you would like returned.
    inputBinding:
      position: 102
      prefix: --columns
  - id: families
    type:
      - 'null'
      - string
    doc: Restrict analysis to a specific set of 1 or more (comma) separated) 
      families
    inputBinding:
      position: 102
      prefix: --families
  - id: filter
    type:
      - 'null'
      - string
    doc: Restrictions to apply to variants (SQL syntax)
    inputBinding:
      position: 102
      prefix: --filter
  - id: min_gq
    type:
      - 'null'
      - int
    doc: The minimum genotype quality required for each sample in a family
    inputBinding:
      position: 102
      prefix: --min-gq
  - id: min_kindreds
    type:
      - 'null'
      - int
    doc: The min. number of kindreds that must have a candidate variant in a 
      gene.
    inputBinding:
      position: 102
      prefix: --min-kindreds
  - id: min_sample_depth
    type:
      - 'null'
      - int
    doc: The minimum aligned sequence depth required for each sample in a family
    inputBinding:
      position: 102
      prefix: -d
  - id: x_chrom_name
    type:
      - 'null'
      - string
    doc: name of X chrom (if not default 'chrX' or 'X')
    inputBinding:
      position: 102
      prefix: X
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_x_linked_de_novo.out
