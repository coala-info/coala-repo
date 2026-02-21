cwlVersion: v1.2
class: CommandLineTool
baseCommand: parasol
label: ucsc-parasol
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parasol:482--h0b57e2e_0
stdout: ucsc-parasol.out
