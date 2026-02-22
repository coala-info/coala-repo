cwlVersion: v1.2
class: CommandLineTool
baseCommand: peaks2utr
label: peaks2utr
doc: "The provided text contains error messages related to a container execution failure
  (no space left on device) and does not contain the actual help text or usage instructions
  for the tool. Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/haessar/peaks2utr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peaks2utr:1.4.1--pyhdfd78af_0
stdout: peaks2utr.out
