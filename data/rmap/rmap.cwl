cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmap
label: rmap
doc: "The provided text is a container build error log and does not contain help documentation
  or usage instructions for the tool.\n\nTool homepage: https://github.com/juruen/rmapi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmap:2.1--0
stdout: rmap.out
