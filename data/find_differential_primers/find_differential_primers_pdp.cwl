cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_differential_primers_pdp
label: find_differential_primers_pdp
doc: "A tool for finding differential primers. Note: The provided input text contains
  container runtime error messages rather than the tool's help documentation, so no
  arguments could be extracted.\n\nTool homepage: https://github.com/widdowquinn/find_differential_primers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
stdout: find_differential_primers_pdp.out
