cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCat
label: ucsc-pslcat
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) failing to pull the
  image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcat:482--h0b57e2e_0
stdout: ucsc-pslcat.out
