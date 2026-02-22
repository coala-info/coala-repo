cwlVersion: v1.2
class: CommandLineTool
baseCommand: phnml-jupyter
label: phnml-jupyter
doc: The provided text contains system error messages related to a 
  Singularity/Docker container execution failure and does not contain help 
  documentation or argument definitions for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phnml-jupyter:latest
stdout: phnml-jupyter.out
