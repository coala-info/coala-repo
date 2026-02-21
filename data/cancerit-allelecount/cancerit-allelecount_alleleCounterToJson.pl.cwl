cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounterToJson.pl
label: cancerit-allelecount_alleleCounterToJson.pl
doc: "A script to convert alleleCount output to JSON format. Note: The provided help
  text contains only system error logs and does not list specific arguments.\n\nTool
  homepage: https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cancerit-allelecount:4.3.0--h8bd2d3b_7
stdout: cancerit-allelecount_alleleCounterToJson.pl.out
