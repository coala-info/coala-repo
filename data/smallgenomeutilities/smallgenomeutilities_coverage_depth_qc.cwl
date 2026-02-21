cwlVersion: v1.2
class: CommandLineTool
baseCommand: coverage_depth_qc
label: smallgenomeutilities_coverage_depth_qc
doc: "A tool from the smallgenomeutilities suite. Note: The provided text contains
  container runtime logs and error messages rather than the tool's help documentation,
  so specific arguments could not be extracted.\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_coverage_depth_qc.out
