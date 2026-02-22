cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconvert
label: bioconvert
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a lack of disk space during a container
  image pull.\n\nTool homepage: http://bioconvert.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
stdout: bioconvert.out
