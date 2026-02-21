cwlVersion: v1.2
class: CommandLineTool
baseCommand: capc-map
label: capc-map
doc: "A tool for mapping and analyzing Capture-C data. (Note: The provided text appears
  to be a container build error log rather than help text; therefore, specific arguments
  could not be extracted from the input.)\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
stdout: capc-map.out
