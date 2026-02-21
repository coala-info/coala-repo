cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFrag
label: ucsc-maffrag
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maffrag:482--h0b57e2e_0
stdout: ucsc-maffrag.out
