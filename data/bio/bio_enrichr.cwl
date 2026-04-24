cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_enrichr
doc: "Runs the enrichr tool on a csv file where one column contains gene names and
  some column contains pvalues.\n\nFilters the p values by a threshold, then submits
  the gene names to g:GOSt.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: counts_file
    type:
      - 'null'
      - File
    doc: input counts
    inputBinding:
      position: 101
      prefix: --counts
  - id: gene_id_column_name
    type:
      - 'null'
      - string
    doc: gene id column name
    inputBinding:
      position: 101
      prefix: --colname
  - id: organism
    type:
      - 'null'
      - string
    doc: input counts
    inputBinding:
      position: 101
      prefix: --organism
  - id: pvalue_column_name
    type:
      - 'null'
      - string
    doc: pvalue column name
    inputBinding:
      position: 101
      prefix: --pval-column
  - id: pvalue_cutoff
    type:
      - 'null'
      - float
    doc: pvalue cutoff
    inputBinding:
      position: 101
      prefix: --pval-cutoff
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: pvalue column name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
