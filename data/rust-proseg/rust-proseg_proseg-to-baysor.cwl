cwlVersion: v1.2
class: CommandLineTool
baseCommand: proseg-to-baysor
label: rust-proseg_proseg-to-baysor
doc: "A tool to convert proseg output to Baysor format. (Note: The provided help text
  contains only container runtime error logs and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/dcjones/proseg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0
stdout: rust-proseg_proseg-to-baysor.out
