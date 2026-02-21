cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sonneityping
  - mykrobe
label: sonneityping_mykrobe
doc: "Note: The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/katholt/sonneityping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sonneityping:20210201
stdout: sonneityping_mykrobe.out
