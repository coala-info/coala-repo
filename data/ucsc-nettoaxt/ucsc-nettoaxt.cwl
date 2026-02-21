cwlVersion: v1.2
class: CommandLineTool
baseCommand: netToAxt
label: ucsc-nettoaxt
doc: "The provided text does not contain help information for the tool, as it is a
  fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the OCI image. Consequently, no arguments or tool descriptions
  could be extracted from the input.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nettoaxt:482--h0b57e2e_0
stdout: ucsc-nettoaxt.out
