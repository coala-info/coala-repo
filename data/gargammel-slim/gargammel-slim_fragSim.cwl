cwlVersion: v1.2
class: CommandLineTool
baseCommand: fragSim
label: gargammel-slim_fragSim
doc: "A tool from the gargammel-slim suite (description unavailable due to execution
  error in provided text).\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
stdout: gargammel-slim_fragSim.out
