cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_select
label: xsv_select
doc: "Select columns from CSV data efficiently.\n\nThis command lets you manipulate
  the columns in CSV data. You can re-order\nthem, duplicate them or drop them. Columns
  can be referenced by index or by\nname if there is a header row (duplicate column
  names can be disambiguated with\nmore indexing). Finally, column ranges can be specified.\n\
  \nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: selection
    type: string
    doc: Column selection (e.g., '1,4', '1-4', '3-', '!1-2', 'Foo[2]', 
      '3-1,Header3-Header1,Header1,Foo[2],Header1')
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 2
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "The field delimiter for reading CSV data.\n                           Must
      be a single character."
    default: ','
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be interpreted as headers. (i.e., They
      are not searched, analyzed, sliced, etc.)
    inputBinding:
      position: 103
      prefix: --no-headers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to <file> instead of stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
