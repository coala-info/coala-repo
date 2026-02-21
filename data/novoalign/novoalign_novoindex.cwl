cwlVersion: v1.2
class: CommandLineTool
baseCommand: novoindex
label: novoalign_novoindex
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: http://www.novocraft.com/products/novoalign/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoalign:4.03.04--h5ca1c30_4
stdout: novoalign_novoindex.out
