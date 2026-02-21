cwlVersion: v1.2
class: CommandLineTool
baseCommand: sglearn
label: sglearn
doc: "The provided text does not contain help information or a description for the
  tool. It is an error log from a container build process.\n\nTool homepage: https://github.com/gpp-rnd/sglearn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sglearn:1.2.5--pyhdfd78af_0
stdout: sglearn.out
