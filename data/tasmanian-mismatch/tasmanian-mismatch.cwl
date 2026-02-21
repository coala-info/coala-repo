cwlVersion: v1.2
class: CommandLineTool
baseCommand: tasmanian-mismatch
label: tasmanian-mismatch
doc: "A tool for mismatch analysis (Note: The provided text contains system logs and
  error messages rather than command-line help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://github.com/nebiolabs/tasmanian-mismatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
stdout: tasmanian-mismatch.out
