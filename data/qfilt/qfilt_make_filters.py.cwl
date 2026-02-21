cwlVersion: v1.2
class: CommandLineTool
baseCommand: qfilt_make_filters.py
label: qfilt_make_filters.py
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/NathanGodey/qfilters"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qfilt:0.0.1--h9948957_7
stdout: qfilt_make_filters.py.out
