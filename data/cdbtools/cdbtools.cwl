cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbtools
label: cdbtools
doc: "The provided text is a system error log related to a container build failure
  (no space left on device) and does not contain CLI help information or argument
  definitions for cdbtools.\n\nTool homepage: https://github.com/philpennock/cdbtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
stdout: cdbtools.out
