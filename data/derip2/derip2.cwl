cwlVersion: v1.2
class: CommandLineTool
baseCommand: derip2
label: derip2
doc: "Note: The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the tool's help documentation or argument definitions.\n\n
  Tool homepage: https://github.com/Adamtaranto/deRIP2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/derip2:0.4.1--pyhdfd78af_0
stdout: derip2.out
