cwlVersion: v1.2
class: CommandLineTool
baseCommand: frameshift_deletions_checks
label: smallgenomeutilities_frameshift_deletions_checks
doc: "A tool from the smallgenomeutilities suite to check for frameshift deletions.
  (Note: The provided help text contained only container runtime error messages and
  no usage information.)\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_frameshift_deletions_checks.out
