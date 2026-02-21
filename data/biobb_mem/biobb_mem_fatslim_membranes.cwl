cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_mem_fatslim_membranes
label: biobb_mem_fatslim_membranes
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_mem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
stdout: biobb_mem_fatslim_membranes.out
