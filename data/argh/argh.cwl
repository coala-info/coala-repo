cwlVersion: v1.2
class: CommandLineTool
baseCommand: argh
label: argh
doc: "The provided text does not contain help information for the tool 'argh'. It
  consists of system logs and an error message indicating that the executable was
  not found.\n\nTool homepage: https://github.com/google/argh"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argh:0.26.2--py36_0
stdout: argh.out
