cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - get_taxonomy_results
label: enasearch_get_taxonomy_results
doc: "Get list of taxonomy results.\n\nThis function returns the  description about the possible results accessible via the taxon portal. Each taxonomy result is described with a short description\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_taxonomy_results.out
