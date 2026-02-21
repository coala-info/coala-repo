cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantpi
label: quantpi
doc: "The provided text appears to be a container build log rather than command-line
  help text. No tool description or arguments could be extracted.\n\nTool homepage:
  https://github.com/ohmeta/quantpi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
stdout: quantpi.out
