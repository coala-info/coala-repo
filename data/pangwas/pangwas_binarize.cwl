cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - binarize
label: pangwas_binarize
doc: "Convert a categorical column to multiple binary (0/1) columns.\n\nTakes as input a table (TSV or CSV) and the name of a column to binarize.\nOutputs a new table with separate columns for each categorical value.\n\nAny additional arguments will be passed to `pyseer`.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: table
    type: File
    doc: "TSV or CSV table."
    inputBinding:
      position: 101
      prefix: --table
  - id: column
    type: string
    doc: "Column name to binarize."
    inputBinding:
      position: 101
      prefix: --column
  - id: column_prefix
    type:
      - 'null'
      - string
    doc: "Prefix to add to column names."
    inputBinding:
      position: 101
      prefix: --column-prefix
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_delim
    type:
      - 'null'
      - string
    doc: "Output delimiter. (default: tab)"
    inputBinding:
      position: 101
      prefix: --output-delim
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: "Tranpose output table."
    inputBinding:
      position: 101
      prefix: --transpose
outputs:
  - id: binarized_table
    type: File
    doc: "Table with one binary (0/1) column per category (.tsv for tab, .csv for comma)"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'binarize.*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
