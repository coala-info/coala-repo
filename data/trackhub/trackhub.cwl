cwlVersion: v1.2
class: CommandLineTool
baseCommand: trackhub
label: trackhub
doc: "The provided text is a log of a failed container build process and does not
  contain help information or argument definitions for the 'trackhub' tool.\n\nTool
  homepage: http://github.com/daler/trackhub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trackhub:1.0--pyh7cba7a3_0
stdout: trackhub.out
