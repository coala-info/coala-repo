cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbiotools
label: pbiotools
doc: "The provided text contains system error messages and logs related to a container
  execution failure (no space left on device) rather than help text or usage instructions.
  Consequently, no arguments or tool descriptions could be extracted.\n\nTool homepage:
  https://github.com/dieterich-lab/pbiotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbiotools:5.0.0--pyhdfd78af_0
stdout: pbiotools.out
