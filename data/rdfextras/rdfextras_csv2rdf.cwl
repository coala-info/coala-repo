cwlVersion: v1.2
class: CommandLineTool
baseCommand: csv2rdf
label: rdfextras_csv2rdf
doc: "A tool to convert CSV files to RDF. Note: The provided help text contains only
  system logs and error messages; no specific arguments could be extracted from the
  input.\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_csv2rdf.out
