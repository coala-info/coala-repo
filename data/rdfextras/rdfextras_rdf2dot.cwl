cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdf2dot
label: rdfextras_rdf2dot
doc: "Converts RDF graphs to the DOT graph description language.\n\nTool homepage:
  https://github.com/RDFLib/rdfextras"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input RDF file (defaults to stdin)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: RDF serialization format (e.g., 'turtle', 'xml', 'json-ld')
    inputBinding:
      position: 102
      prefix: --format
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output DOT file (defaults to stdout)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
