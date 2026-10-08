cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - export_pangenome
label: pantools_export_pangenome
doc: "Export a pangenome built with build_pangenome into node properties, relationship\
  \ properties and node sequence anchors files.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: node_properties_file
    type:
      - 'null'
      - string
    doc: Name of the node properties output file.
    inputBinding:
      position: 102
      prefix: --node-properties-file=
      separate: false
  - id: relationship_properties_file
    type:
      - 'null'
      - string
    doc: Name of the relationship properties output file.
    inputBinding:
      position: 102
      prefix: --relationship-properties-file=
      separate: false
  - id: sequence_node_anchors_file
    type:
      - 'null'
      - string
    doc: Name of the sequence node anchors output file.
    inputBinding:
      position: 102
      prefix: --sequence-node-anchors-file=
      separate: false
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: node_properties
    type:
      - 'null'
      - File
    doc: The exported node properties file.
    outputBinding:
      glob: $(inputs.node_properties_file)
  - id: relationship_properties
    type:
      - 'null'
      - File
    doc: The exported relationship properties file.
    outputBinding:
      glob: $(inputs.relationship_properties_file)
  - id: sequence_node_anchors
    type:
      - 'null'
      - File
    doc: The exported sequence node anchors file.
    outputBinding:
      glob: $(inputs.sequence_node_anchors_file)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_export_pangenome.log
