cwlVersion: v1.2
class: CommandLineTool
baseCommand: sonneityping
label: sonneityping
doc: "A tool for Shigella sonnei typing. (Note: The provided text is a container build
  error log and does not contain CLI help information or argument definitions.)\n\n
  Tool homepage: https://github.com/katholt/sonneityping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sonneityping:20210201
stdout: sonneityping.out
