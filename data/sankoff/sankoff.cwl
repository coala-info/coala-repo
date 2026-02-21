cwlVersion: v1.2
class: CommandLineTool
baseCommand: sankoff
label: sankoff
doc: "The provided text contains system logs and error messages related to fetching
  a container image for 'sankoff', but does not contain the tool's help text or usage
  information. Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/hzi-bifo/sankoff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sankoff:0.2--h9948957_5
stdout: sankoff.out
