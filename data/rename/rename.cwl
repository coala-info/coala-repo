cwlVersion: v1.2
class: CommandLineTool
baseCommand: rename
label: rename
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process.\n\nTool homepage:
  http://plasmasturm.org/code/rename"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rename:1.601--0
stdout: rename.out
