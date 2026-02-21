cwlVersion: v1.2
class: CommandLineTool
baseCommand: lightstringgraph_redbuild
label: lightstringgraph_redbuild
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log indicating a failure to build or run a container due
  to insufficient disk space.\n\nTool homepage: http://lsg.algolab.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h205c40f_2
stdout: lightstringgraph_redbuild.out
