cwlVersion: v1.2
class: CommandLineTool
baseCommand: alfred
label: alfred
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the tool 'alfred'.\n
  \nTool homepage: https://github.com/tobiasrausch/alfred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
stdout: alfred.out
