cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringify
label: ucsc-stringify
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-stringify:482--hdc0a859_1
stdout: ucsc-stringify.out
