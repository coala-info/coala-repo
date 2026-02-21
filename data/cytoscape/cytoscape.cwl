cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytoscape
label: cytoscape
doc: "Cytoscape is an open source software platform for visualizing complex networks
  and integrating these with any type of attribute data. (Note: The provided text
  appears to be a container build error log rather than CLI help text, so no arguments
  could be extracted.)\n\nTool homepage: https://cytoscape.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytoscape:3.10.4--he65b2d3_0
stdout: cytoscape.out
