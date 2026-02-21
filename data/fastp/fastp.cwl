cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastp
label: fastp
doc: "The provided text does not contain help documentation for fastp; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the fastp image due to lack of disk space.\n\nTool homepage: https://github.com/OpenGene/fastp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastp:1.1.0--heae3180_0
stdout: fastp.out
