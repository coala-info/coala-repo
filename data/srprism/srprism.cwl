cwlVersion: v1.2
class: CommandLineTool
baseCommand: srprism
label: srprism
doc: "The provided text does not contain help information for srprism; it contains
  error logs from a container runtime (Apptainer/Singularity) failing to fetch the
  image.\n\nTool homepage: https://github.com/ncbi/SRPRISM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
stdout: srprism.out
