cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitp
label: splitp
doc: "The provided text is a container execution error log and does not contain help
  documentation or argument definitions for the tool 'splitp'.\n\nTool homepage: https://github.com/COMBINE-lab/splitp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitp:0.2.0--h9948957_1
stdout: splitp.out
