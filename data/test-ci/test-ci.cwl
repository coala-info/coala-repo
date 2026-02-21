cwlVersion: v1.2
class: CommandLineTool
baseCommand: test-ci
label: test-ci
doc: "A tool for CI testing. (Note: The provided text appears to be execution logs/error
  messages rather than help documentation, so no arguments could be extracted.)\n\n
  Tool homepage: https://github.com/lh3/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/test-ci:v0.0.2.22
stdout: test-ci.out
