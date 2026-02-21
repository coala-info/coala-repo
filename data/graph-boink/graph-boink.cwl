cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph-boink
label: graph-boink
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool 'graph-boink'.\n
  \nTool homepage: https://github.com/camillescott/boink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graph-boink:0.11--py37h8b12597_0
stdout: graph-boink.out
