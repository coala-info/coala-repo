cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - vtNormalize
label: cannoli_vtNormalize
doc: "Normalize variants using vt. (Note: The provided help text contains only system
  error messages regarding a failed container build and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_vtNormalize.out
