cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ptgaul
  - sort
label: ptgaul_sort
doc: "The provided text does not contain help information for the tool; it appears
  to be an error log from a container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_sort.out
