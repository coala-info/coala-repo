cwlVersion: v1.2
class: CommandLineTool
baseCommand: gargammel_fragSim
label: gargammel_fragSim
doc: "A tool from the gargammel package (description unavailable due to error in provided
  help text).\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel:1.1.4--hb66fcc3_0
stdout: gargammel_fragSim.out
