cwlVersion: v1.2
class: CommandLineTool
baseCommand: featureBits
label: ucsc-featurebits
doc: "The provided text does not contain help information for the tool; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to fetch or build the image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-featurebits:482--h0b57e2e_0
stdout: ucsc-featurebits.out
