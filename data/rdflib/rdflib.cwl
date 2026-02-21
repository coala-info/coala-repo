cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdflib
label: rdflib
doc: "A Python library for working with RDF. Note: The provided text appears to be
  a container build log error rather than CLI help text, so no arguments could be
  extracted.\n\nTool homepage: https://github.com/RDFLib/rdflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdflib:4.2.2--py34_0
stdout: rdflib.out
