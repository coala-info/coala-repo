cwlVersion: v1.2
class: CommandLineTool
baseCommand: qhery
label: qhery
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or usage instructions for the tool 'qhery'.\n\nTool homepage:
  http://github.com/mjsull/qhery/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhery:0.1.2--pyhdfd78af_0
stdout: qhery.out
