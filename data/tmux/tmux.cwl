cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmux
label: tmux
doc: "The provided text does not contain help information for tmux; it appears to
  be a log from a failed container build process (Apptainer/Singularity).\n\nTool
  homepage: https://github.com/tmux/tmux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmux:2.1--1
stdout: tmux.out
