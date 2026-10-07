cwlVersion: v1.2
class: CommandLineTool
baseCommand: collect-columns
label: collect-columns
doc: "Retrieves a column from a set of tables and puts them into a single table.
  Optionally, additional attributes may be retrieved from a GTF or GFF file, which
  will be added as additional column in the merged table as well.\n\nTool homepage:
  https://github.com/biowdl/collect-columns"
inputs:
  - id: output_name
    type: string
    doc: The path the output will be written to.
    inputBinding:
      position: 2
  - id: tables
    type:
      type: array
      items: File
    doc: The tables to be merged.
    inputBinding:
      position: 3
  - id: feature_column
    type:
      - 'null'
      - int
    doc: The position of the column with the (unique) feature ids. Default to 0.
    inputBinding:
      position: 0
      prefix: --feature-column
  - id: value_column
    type:
      - 'null'
      - int
    doc: The position of the column with the values of interest. Defaults to 1.
    inputBinding:
      position: 0
      prefix: --value-column
  - id: separator
    type:
      - 'null'
      - string
    doc: The separator used in the tables. This will also be used in the output 
      table. Defaults to a tab.
    inputBinding:
      position: 0
      prefix: --separator
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: The names of the samples corresponding to the tables (in the same order
      as the tables). These will be used as headers in the merged table. If not 
      specified the basenames of tables will be used.
    inputBinding:
      position: 0
      prefix: --names
  - id: header
    type:
      - 'null'
      - boolean
    doc: Whether or not the tables have a header. Defaults to false.
    inputBinding:
      position: 0
      prefix: --header
  - id: sum_on_duplicate_id
    type:
      - 'null'
      - boolean
    doc: Whether or not values should be added up if multiple rows exist with 
      the same feature id. The values will become floats if this flag is set.
    inputBinding:
      position: 0
      prefix: --sum-on-duplicate-id
  - id: additional_attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of attributes which will be added to the merged table. These 
      attributes will be retrieved from the GTF or GFF file specified with the -g
      option. Requires -g to be specified.
    inputBinding:
      position: 0
      prefix: --additional-attributes
  - id: gtf
    type:
      - 'null'
      - File
    doc: The GTF or GFF file from which the additional attributes (see -a) will 
      be retrieved.
    inputBinding:
      position: 0
      prefix: --gtf
  - id: feature_attribute
    type:
      - 'null'
      - string
    doc: The attribute from the GTF/GFF used for matching the feature records 
      with the rows in the table. Defaults to 'gene_id'.
    inputBinding:
      position: 0
      prefix: --feature-attribute
arguments:
  - position: 1
    valueFrom: --
outputs:
  - id: output_file
    type: File
    doc: The merged table.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/collect-columns:1.0.0--py_0
