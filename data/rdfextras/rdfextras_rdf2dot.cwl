cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdf2dot
label: rdfextras_rdf2dot
doc: "Read RDF files and write a graph of the RDF data in DOT language to stdout\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: RDF files to read
    inputBinding:
      position: 3
  - id: format
    type:
      - 'null'
      - string
    doc: "parser to use (for example xml, n3, turtle, nt); guessed from the file
      extension if not given (-f)"
    inputBinding:
      position: 1
      prefix: -f
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: write the DOT output to this file instead of stdout (-o)
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: DOT output when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: DOT output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_rdf2dot.out
