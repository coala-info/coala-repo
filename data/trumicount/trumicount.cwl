cwlVersion: v1.2
class: CommandLineTool
baseCommand: trumicount
label: trumicount
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://cibiv.github.io/trumicount/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trumicount:0.9.14--r44hdfd78af_3
stdout: trumicount.out
