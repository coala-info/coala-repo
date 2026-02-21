cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyngost
label: pyngost
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/leosanbu/pyngoST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyngost:1.1.3--pyh7e72e81_0
stdout: pyngost.out
