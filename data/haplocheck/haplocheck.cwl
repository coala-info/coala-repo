cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplocheck
label: haplocheck
doc: "A tool for mitochondrial contamination detection (Note: The provided text contains
  execution errors and log messages rather than help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/genepi/haplocheck"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplocheck:1.3.3--h2a3209d_2
stdout: haplocheck.out
