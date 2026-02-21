cwlVersion: v1.2
class: CommandLineTool
baseCommand: reads2graph
label: reads2graph
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/Jappy0/reads2graph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reads2graph:1.0.0--h503566f_1
stdout: reads2graph.out
