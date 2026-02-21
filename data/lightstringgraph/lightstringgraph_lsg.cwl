cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsg
label: lightstringgraph_lsg
doc: "LightStringGraph (lsg) is a tool for string graph construction. Note: The provided
  text contains system error messages and does not list command-line arguments.\n\n
  Tool homepage: http://lsg.algolab.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h205c40f_2
stdout: lightstringgraph_lsg.out
