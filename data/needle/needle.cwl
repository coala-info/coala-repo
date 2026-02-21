cwlVersion: v1.2
class: CommandLineTool
baseCommand: needle
label: needle
doc: "The provided text does not contain help information or a description of the
  tool. It contains a fatal error message regarding a container build failure (no
  space left on device).\n\nTool homepage: https://github.com/seqan/needle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle.out
