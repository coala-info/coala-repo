cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfpipe
label: rdfextras_rdfpipe
doc: "A tool for parsing and serializing RDF data (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/RDFLib/rdfextras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_rdfpipe.out
