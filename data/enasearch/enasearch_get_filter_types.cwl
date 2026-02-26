cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_filter_types
label: enasearch_get_filter_types
doc: "Get available filter types and their associated operators and value descriptions.\n\
  \nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: filter_type
    type: string
    doc: The type of filter to get information for (e.g., geo_box2, Text, 
      Number).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_filter_types.out
