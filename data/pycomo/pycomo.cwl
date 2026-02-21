cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycomo
label: pycomo
doc: "The provided text is a container build log showing a fatal error and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/univieCUBE/PyCoMo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycomo:0.2.9--pyhdfd78af_0
stdout: pycomo.out
