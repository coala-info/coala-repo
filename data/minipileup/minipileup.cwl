cwlVersion: v1.2
class: CommandLineTool
baseCommand: minipileup
label: minipileup
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/lh3/minipileup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minipileup:1.4b--h577a1d6_0
stdout: minipileup.out
