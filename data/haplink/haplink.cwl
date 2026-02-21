cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplink
label: haplink
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the haplink image due to insufficient disk space.\n\nTool homepage: https://ksumngs.github.io/HapLink.jl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplink:1.1.0--h7b50bb2_1
stdout: haplink.out
