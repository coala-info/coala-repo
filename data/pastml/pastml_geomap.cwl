cwlVersion: v1.2
class: CommandLineTool
baseCommand: geomap
label: pastml_geomap
doc: "Visualisation of locations.\n\nTool homepage: https://github.com/evolbioinfo/pastml"
inputs:
  - id: data
    type: File
    doc: the annotation file in tab/csv format with the first row containing the
      column names.
    inputBinding:
      position: 101
      prefix: --data
  - id: data_sep
    type:
      - 'null'
      - string
    doc: the column separator for the data table. By default is set to tab, i.e.
      for tab file. Set it to ',' if your file is csv.
    inputBinding:
      position: 101
      prefix: --data_sep
  - id: id_index
    type:
      - 'null'
      - int
    doc: the index of the column in the data table that contains the tree tip 
      names, indices start from zero (by default is set to 0).
    inputBinding:
      position: 101
      prefix: --id_index
  - id: country_column
    type: string
    doc: name of the data table column that contains countries.
    inputBinding:
      position: 101
      prefix: --country
  - id: location_column
    type: string
    doc: name of the data table column that contains locations (to be mapped to
      colours).
    inputBinding:
      position: 101
      prefix: --location
  - id: tree
    type:
      - 'null'
      - File
    doc: the input tree in newick format (to only consider ids present in the 
      tree).
    inputBinding:
      position: 101
      prefix: --tree
  - id: colours
    type:
      - 'null'
      - File
    doc: optional way to specify the colours used for location visualisation. 
      Should be a path to a tab-delimited file, with two columns, the first one
      containing possible locations, and the second, named "colour", containing
      colours, in HEX format (for example a6cee3 after a hash sign).
    inputBinding:
      position: 101
      prefix: --colours
  - id: html_path
    type: string
    doc: the output map visualisation file (html).
    inputBinding:
      position: 102
      prefix: --html
outputs:
  - id: html
    type: File
    doc: the output map visualisation file (html).
    outputBinding:
      glob: $(inputs.html_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
