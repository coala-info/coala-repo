cwlVersion: v1.2
class: CommandLineTool
baseCommand: civicpy
label: civicpy
doc: "The provided text does not contain help information or usage instructions for
  civicpy; it is a system error log indicating a failure to build or extract a container
  image due to insufficient disk space.\n\nTool homepage: http://civicpy.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/civicpy:5.1.1--pyhdfd78af_0
stdout: civicpy.out
