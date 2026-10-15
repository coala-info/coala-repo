cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_query_multi_merge_table
label: phyluce_phyluce_probe_query_multi_merge_table
doc: "Query the multimerge taxa to output matching loci\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: db
    type: File
    doc: The database to query
    inputBinding:
      prefix: --db
  - id: output_path
    type:
      - 'null'
      - string
    doc: When using --specific-counts, output a BED file of those loci
    inputBinding:
      prefix: --output
  - id: base_taxon
    type: string
    doc: The base taxon to use.
    inputBinding:
      prefix: --base-taxon
  - id: specific_counts
    type:
      - 'null'
      - int
    doc: Return data for a specific minimum number of taxa.
    inputBinding:
      prefix: --specific-counts
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The file of loci (written when --specific-counts is set).
    outputBinding:
      glob: '$(inputs.output_path ? [inputs.output_path] : [])'
  - id: missing_matrix
    type:
      - 'null'
      - File
    doc: The matrix of loci that missed the count threshold (written when --specific-counts
      is set).
    outputBinding:
      glob: '$(inputs.output_path ? [inputs.output_path + ".missing.matrix"] : [])'
  - id: summary
    type: stdout
    doc: The count summary printed by the tool.
stdout: phyluce_probe_query_multi_merge_table.summary.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
