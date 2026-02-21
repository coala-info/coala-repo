cwlVersion: v1.2
class: CommandLineTool
baseCommand: aveCols
label: ucsc-avecols
doc: "The provided text does not contain help information for the tool. It is a fatal
  error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-avecols:482--h0b57e2e_0
stdout: ucsc-avecols.out
