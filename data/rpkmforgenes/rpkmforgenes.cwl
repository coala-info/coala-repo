cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpkmforgenes
label: rpkmforgenes
doc: The provided text is a container build error log and does not contain the help
  documentation or usage instructions for the tool 'rpkmforgenes'.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpkmforgenes:1.0.1--py27h24bf2e0_1
stdout: rpkmforgenes.out
