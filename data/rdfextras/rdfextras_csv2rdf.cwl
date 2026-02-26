cwlVersion: v1.2
class: CommandLineTool
baseCommand: csv2rdf.py
label: rdfextras_csv2rdf
doc: "Reads csv files from stdin or given files\nif -d is given, use this delimiter\n\
  if -s is given, skips N lines at the start\nCreates a URI from the columns given
  to -i, or automatically by numbering if\nnone is given\nOutputs RDFS labels from
  the columns given to -l\nif -c is given adds a type triple with the given classname\n\
  if -C is given, the class is defined as rdfs:Class\nOutputs one RDF triple per column
  in each row.\nOutput is in n3 format.\nOutput is stdout, unless -o is specified\n\
  \nTool homepage: https://github.com/RDFLib/rdfextras"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: CSV files to read
    inputBinding:
      position: 1
  - id: classname
    type:
      - 'null'
      - string
    doc: classname to add as type triple
    inputBinding:
      position: 102
      prefix: --class
  - id: col_spec
    type:
      - 'null'
      - type: array
        items: string
    doc: specify conversion for columns (e.g., --col0 float())
    inputBinding:
      position: 102
      prefix: --col
  - id: config_file
    type:
      - 'null'
      - File
    doc: config file to read settings from
    inputBinding:
      position: 102
      prefix: -f
  - id: define_class
    type:
      - 'null'
      - boolean
    doc: the class is defined as rdfs:Class
    inputBinding:
      position: 102
      prefix: --defineclass
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter to use for CSV parsing
    inputBinding:
      position: 102
      prefix: -d
  - id: identity_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: identity column(s) to create URI from
    inputBinding:
      position: 102
      prefix: --ident
  - id: instance_base
    type: string
    doc: instance base URI
    inputBinding:
      position: 102
      prefix: --base
  - id: label_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: label columns for RDFS labels
    inputBinding:
      position: 102
      prefix: --label
  - id: property
    type:
      - 'null'
      - type: array
        items: string
    doc: specify specific properties to use (e.g., --prop0 foaf:name)
    inputBinding:
      position: 102
      prefix: --prop
  - id: property_base
    type: string
    doc: property base URI
    inputBinding:
      position: 102
      prefix: --propbase
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: skips N lines at the start
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
