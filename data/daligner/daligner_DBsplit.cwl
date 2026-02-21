cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBsplit
label: daligner_DBsplit
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/thegenemyers/DALIGNER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_DBsplit.out
