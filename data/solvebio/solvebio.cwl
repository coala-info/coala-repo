cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio
label: solvebio
doc: "The provided text is a log of a failed container build (Apptainer/Singularity)
  and does not contain the help text or argument definitions for the solvebio tool.\n
  \nTool homepage: https://github.com/solvebio/solvebio-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio.out
