cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sylph
  - tax
label: sylph_sylph-tax
doc: "Taxonomic profiling with sylph (Note: The provided text contains container execution
  errors rather than help documentation; no arguments could be extracted).\n\nTool
  homepage: https://github.com/bluenote-1577/sylph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
stdout: sylph_sylph-tax.out
