cwlVersion: v1.2
class: CommandLineTool
baseCommand: LAmerge
label: daligner_LAmerge
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to build
  or extract an image due to insufficient disk space.\n\nTool homepage: https://github.com/thegenemyers/DALIGNER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_LAmerge.out
