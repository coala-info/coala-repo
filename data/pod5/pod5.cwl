cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5
label: pod5
doc: "The provided text is a container execution log and does not contain help information
  or argument definitions for the pod5 tool.\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5.out
