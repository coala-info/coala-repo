cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparqlwrapper_rqw
label: sparqlwrapper_rqw
doc: "The provided text does not contain help documentation or usage instructions
  for the tool; it contains system logs and a fatal error message regarding a container
  image build failure.\n\nTool homepage: https://github.com/RDFLib/sparqlwrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparqlwrapper:1.7.6--py35_0
stdout: sparqlwrapper_rqw.out
