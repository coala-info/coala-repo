cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_mem_gorder
label: biobb_mem_gorder
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build process due to insufficient disk
  space.\n\nTool homepage: https://github.com/bioexcel/biobb_mem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
stdout: biobb_mem_gorder.out
