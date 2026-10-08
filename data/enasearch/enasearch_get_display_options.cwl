cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - get_display_options
label: enasearch_get_display_options
doc: "Get the list of possible formats to display the result.\n\nThis function returns the possible formats to display the result of a query on ENA. Each format is described.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_display_options.out
