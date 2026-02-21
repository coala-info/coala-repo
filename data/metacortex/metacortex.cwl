cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacortex
label: metacortex
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the metacortex
  tool.\n\nTool homepage: https://github.com/SR-Martin/metacortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacortex:0.5.1--h7b50bb2_3
stdout: metacortex.out
