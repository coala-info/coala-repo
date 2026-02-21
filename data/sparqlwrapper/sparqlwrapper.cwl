cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparqlwrapper
label: sparqlwrapper
doc: "SPARQLWrapper is a Python wrapper around a SPARQL service to remotely execute
  queries. (Note: The provided text contains container build logs and error messages
  rather than command-line help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/RDFLib/sparqlwrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparqlwrapper:1.7.6--py35_0
stdout: sparqlwrapper.out
