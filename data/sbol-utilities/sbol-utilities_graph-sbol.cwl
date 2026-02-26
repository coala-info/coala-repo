cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph-sbol
label: sbol-utilities_graph-sbol
doc: "Reads an SBOL file and outputs a graph representation.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: in_file
    type: File
    doc: The SBOL file to read.
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: 'The format of the output graph. Supported formats: turtle, jsonld, rdfxml,
      ntriples.'
    default: turtle
    inputBinding:
      position: 102
      prefix: --format
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: The file to write the graph representation to. If not specified, prints
      to stdout.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
