cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini query
label: gemini_query
doc: "Query the GEMINI database.\n\nTool homepage: https://github.com/arq5x/gemini"
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
  - id: dgidb
    type:
      - 'null'
      - boolean
    doc: Request drug-gene interaction info from DGIdb.
    inputBinding:
      position: 102
      prefix: --dgidb
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
      prefix: -q
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
  - id: use_bcolz
    type:
      - 'null'
      - boolean
    doc: use a (previously created) bcolz index to speed genotype queries
    inputBinding:
      position: 102
      prefix: --use-bcolz
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_query.out
