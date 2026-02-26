cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini query
label: oncogemini_query
doc: "Query the oncogemini database.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: carrier_summary_by_phenotype
    type:
      - 'null'
      - string
    doc: Output columns of counts of carriers and non-carriers stratified by the
      given sample phenotype column
    inputBinding:
      position: 102
      prefix: --carrier-summary-by-phenotype
  - id: family_wise
    type:
      - 'null'
      - boolean
    doc: Perform the sample-filter on a family-wise basis.
    inputBinding:
      position: 102
      prefix: --family-wise
  - id: format
    type:
      - 'null'
      - string
    doc: Format of output (JSON, TPED or default)
    inputBinding:
      position: 102
      prefix: --format
  - id: gt_filter
    type:
      - 'null'
      - string
    doc: Restrictions to apply to genotype values
    inputBinding:
      position: 102
      prefix: --gt-filter
  - id: header
    type:
      - 'null'
      - boolean
    doc: Add a header of column names to the output.
    inputBinding:
      position: 102
      prefix: --header
  - id: in_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: A variant must be in either all, none or any samples passing the 
      --sample-query filter.
    inputBinding:
      position: 102
      prefix: --in
  - id: min_kindreds
    type:
      - 'null'
      - int
    doc: Minimum number of families for a variant passing a family-wise filter 
      to be in.
    inputBinding:
      position: 102
      prefix: --min-kindreds
  - id: query_str
    type:
      - 'null'
      - string
    doc: The query to be issued to the database
    inputBinding:
      position: 102
      prefix: --query-str
  - id: region
    type:
      - 'null'
      - string
    doc: Restrict query to this region, e.g. chr1:10-20.
    inputBinding:
      position: 102
      prefix: --region
  - id: sample_delim
    type:
      - 'null'
      - string
    doc: The delimiter to be used with the --show-samples option.
    inputBinding:
      position: 102
      prefix: --sample-delim
  - id: sample_filter
    type:
      - 'null'
      - string
    doc: SQL filter to use to filter the sample table
    inputBinding:
      position: 102
      prefix: --sample-filter
  - id: show_families
    type:
      - 'null'
      - boolean
    doc: Add a column listing all of the families with a variant to each 
      variant.
    inputBinding:
      position: 102
      prefix: --show-families
  - id: show_samples
    type:
      - 'null'
      - boolean
    doc: Add a column of all sample names with a variant to each variant.
    inputBinding:
      position: 102
      prefix: --show-samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_query.out
