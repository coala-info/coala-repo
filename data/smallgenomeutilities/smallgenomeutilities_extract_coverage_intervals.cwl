cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smallgenomeutilities
  - extract_coverage_intervals
label: smallgenomeutilities_extract_coverage_intervals
doc: "Extract coverage intervals from genomic data.\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_extract_coverage_intervals.out
