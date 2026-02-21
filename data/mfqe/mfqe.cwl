cwlVersion: v1.2
class: CommandLineTool
baseCommand: mfqe
label: mfqe
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool 'mfqe'.\n
  \nTool homepage: https://github.com/wwood/mfqe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mfqe:0.5.0--h7b50bb2_5
stdout: mfqe.out
