cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfextras
label: rdfextras
doc: "RDFExtras is a collection of packages providing extra features for RDFLib, such
  as non-standard SPARQL extensions and database backends.\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras.out
