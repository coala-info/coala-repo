cwlVersion: v1.2
class: CommandLineTool
baseCommand: faRandomize
label: ucsc-farandomize
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch the image.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-farandomize:482--h0b57e2e_0
stdout: ucsc-farandomize.out
