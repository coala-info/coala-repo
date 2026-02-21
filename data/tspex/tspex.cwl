cwlVersion: v1.2
class: CommandLineTool
baseCommand: tspex
label: tspex
doc: "The provided text is a system error log indicating a failed container build
  (no space left on device) and does not contain help text or argument definitions
  for the tool 'tspex'.\n\nTool homepage: https://github.com/apcamargo/tspex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tspex:0.6.3--pyhdfd78af_0
stdout: tspex.out
