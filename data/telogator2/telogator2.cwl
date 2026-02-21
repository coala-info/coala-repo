cwlVersion: v1.2
class: CommandLineTool
baseCommand: telogator2
label: telogator2
doc: "The provided text is a container execution error log and does not contain help
  documentation or argument definitions for telogator2.\n\nTool homepage: https://github.com/zstephens/telogator2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telogator2:2.2.3--pyhdfd78af_0
stdout: telogator2.out
