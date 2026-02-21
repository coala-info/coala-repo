cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysvmlight
label: pysvmlight
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: https://bitbucket.org/wcauchois/pysvmlight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysvmlight:0.4--py27h470a237_1
stdout: pysvmlight.out
