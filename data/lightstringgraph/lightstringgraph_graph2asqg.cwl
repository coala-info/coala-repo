cwlVersion: v1.2
class: CommandLineTool
baseCommand: lightstringgraph_graph2asqg
label: lightstringgraph_graph2asqg
doc: "A tool within the lightstringgraph suite (description unavailable due to execution
  error in provided text).\n\nTool homepage: http://lsg.algolab.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h205c40f_2
stdout: lightstringgraph_graph2asqg.out
