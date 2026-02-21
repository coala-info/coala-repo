cwlVersion: v1.2
class: CommandLineTool
baseCommand: dialign2
label: dialign2
doc: "DIALIGN is a segment-based multiple sequence alignment tool. Note: The provided
  help text contains a system error (no space left on device) and does not list command-line
  arguments.\n\nTool homepage: http://dialign.gobics.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dialign2:2.2.1--h9948957_9
stdout: dialign2.out
