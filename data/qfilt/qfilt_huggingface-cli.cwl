cwlVersion: v1.2
class: CommandLineTool
baseCommand: qfilt
label: qfilt_huggingface-cli
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/NathanGodey/qfilters"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qfilt:0.0.1--h9948957_7
stdout: qfilt_huggingface-cli.out
