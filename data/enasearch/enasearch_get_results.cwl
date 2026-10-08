cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - get_results
label: enasearch_get_results
doc: "Get the possible results (type of data).\n\nThis function return the possible results (or type of data) accessible with ENA with their ids and a short description\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_results.out
