cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounter.pl
label: cancerit-allelecount_alleleCounter.pl
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cancerit-allelecount:4.3.0--h8bd2d3b_7
stdout: cancerit-allelecount_alleleCounter.pl.out
