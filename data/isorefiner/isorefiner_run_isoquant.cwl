cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner_run_isoquant
label: isorefiner_run_isoquant
doc: "Run IsoQuant as part of the IsoRefiner pipeline. (Note: The provided text contains
  system error logs regarding container image conversion and does not include specific
  CLI usage or argument definitions.)\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_run_isoquant.out
