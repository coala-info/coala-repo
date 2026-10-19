cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfgraphisomorphism
label: rdfextras_rdfgraphisomorphism
doc: "Tests if RDF graphs are isomorphic, that is equal when blank node labels are
  ignored. Stops with an assertion error when two graphs differ.\n\nTool homepage:
  https://github.com/RDFLib/rdfextras"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: RDF files to compare (file1 file2 ... fileN)
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: "format of the RDF documents to compare: xml, n3, trix, nt or rdfa (default
      xml)"
    inputBinding:
      position: 1
      prefix: --format
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: load from STDIN as well
    inputBinding:
      position: 1
      prefix: --stdin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (empty when all graphs are isomorphic)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_rdfgraphisomorphism.out
