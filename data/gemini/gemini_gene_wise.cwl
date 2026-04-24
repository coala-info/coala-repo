cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini gene_wise
label: gemini_gene_wise
doc: "Perform gene-wise analysis on a GEMINI database.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: Path to the GEMINI database file.
    inputBinding:
      position: 1
  - id: columns
    type:
      - 'null'
      - string
    doc: Comma-separated list of columns to retrieve.
    inputBinding:
      position: 102
      prefix: --columns
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter to apply to variants.
    inputBinding:
      position: 102
      prefix: --filter
  - id: gt_filter
    type:
      - 'null'
      - string
    doc: Genotype filter to apply.
    inputBinding:
      position: 102
      prefix: --gt-filter
  - id: gt_filter_required
    type:
      - 'null'
      - string
    doc: Specify filter(s) that must be met. A variant passing this filter is 
      required and does not contribute to '--min-filters'.
    inputBinding:
      position: 102
      prefix: --gt-filter-required
  - id: min_filters
    type:
      - 'null'
      - string
    doc: Minimum number of filters that must be met for a variant to be 
      included.
    inputBinding:
      position: 102
      prefix: --min-filters
  - id: where
    type:
      - 'null'
      - string
    doc: SQL WHERE clause to subset variants.
    inputBinding:
      position: 102
      prefix: --where
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_gene_wise.out
