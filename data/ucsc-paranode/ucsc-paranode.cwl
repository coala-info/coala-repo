cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNode
label: ucsc-paranode
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) attempting to fetch
  the tool image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode.out
