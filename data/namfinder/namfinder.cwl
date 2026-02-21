cwlVersion: v1.2
class: CommandLineTool
baseCommand: namfinder
label: namfinder
doc: "The provided text contains error logs from a container runtime and does not
  include the help documentation for namfinder. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/ksahlin/namfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/namfinder:0.1.3--h077b44d_2
stdout: namfinder.out
