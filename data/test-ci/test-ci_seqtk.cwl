cwlVersion: v1.2
class: CommandLineTool
baseCommand: test-ci_seqtk
label: test-ci_seqtk
doc: "The provided text is a container build/execution log and does not contain help
  documentation or argument definitions for the tool.\n\nTool homepage: https://github.com/lh3/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/test-ci:v0.0.2.22
stdout: test-ci_seqtk.out
