cwlVersion: v1.2
class: CommandLineTool
baseCommand: vase_reporter
label: vase_vase_reporter
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/david-a-parry/vase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vase:0.5.1--pyh086e186_0
stdout: vase_vase_reporter.out
