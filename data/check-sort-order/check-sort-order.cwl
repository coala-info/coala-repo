cwlVersion: v1.2
class: CommandLineTool
baseCommand: check-sort-order
label: check-sort-order
doc: "A tool to check the sort order of a file. (Note: The provided help text contains
  only system logs and build errors; no specific arguments or options were listed
  in the input.)\n\nTool homepage: https://github.com/gogetdata/ggd-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/check-sort-order:0.0.7--h9ee0642_1
stdout: check-sort-order.out
