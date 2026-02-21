cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdf2dot
label: rdfextras_rdf2dot
doc: "A tool for converting RDF data to DOT format for visualization. (Note: The provided
  input text contained container execution logs rather than command-line help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_rdf2dot.out
