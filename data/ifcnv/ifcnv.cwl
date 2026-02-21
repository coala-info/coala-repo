cwlVersion: v1.2
class: CommandLineTool
baseCommand: ifcnv
label: ifcnv
doc: "The provided text does not contain help information or a description of the
  tool; it is an error message indicating a failure to pull or build the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/SimCab-CHU/ifCNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ifcnv:0.2.1--pyh5e36f6f_0
stdout: ifcnv.out
