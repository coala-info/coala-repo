cwlVersion: v1.2
class: CommandLineTool
baseCommand: vechat
label: vechat
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the 'vechat' tool.\n\nTool
  homepage: https://github.com/HaploKit/vechat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vechat:1.1.1--hd03093a_0
stdout: vechat.out
