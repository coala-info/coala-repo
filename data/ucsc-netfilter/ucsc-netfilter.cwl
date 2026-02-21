cwlVersion: v1.2
class: CommandLineTool
baseCommand: netFilter
label: ucsc-netfilter
doc: "The provided text does not contain help information for the tool. It appears
  to be a container engine error log (Apptainer/Singularity) reporting a failure to
  fetch the OCI image for ucsc-netfilter.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netfilter:482--h0b57e2e_0
stdout: ucsc-netfilter.out
