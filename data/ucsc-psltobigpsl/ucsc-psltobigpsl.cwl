cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToBigPsl
label: ucsc-psltobigpsl
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or fetch the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobigpsl:482--h0b57e2e_0
stdout: ucsc-psltobigpsl.out
