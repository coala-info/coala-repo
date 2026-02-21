cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_mem
label: biobb_mem
doc: "The provided text does not contain help information or usage instructions. It
  is a log of a failed container build process due to insufficient disk space.\n\n
  Tool homepage: https://github.com/bioexcel/biobb_mem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
stdout: biobb_mem.out
