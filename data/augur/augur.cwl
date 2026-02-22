cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur
label: augur
doc: "The provided text contains system error logs regarding a container execution
  failure (no space left on device) and does not contain the help documentation or
  argument definitions for the tool.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur.out
