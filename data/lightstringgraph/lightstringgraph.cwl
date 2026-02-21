cwlVersion: v1.2
class: CommandLineTool
baseCommand: lightstringgraph
label: lightstringgraph
doc: "A tool for string graph construction (Note: The provided text is a container
  runtime error message and does not contain help documentation or argument details).\n
  \nTool homepage: http://lsg.algolab.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h205c40f_2
stdout: lightstringgraph.out
