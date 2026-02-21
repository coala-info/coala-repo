cwlVersion: v1.2
class: CommandLineTool
baseCommand: popera
label: popera
doc: "A tool for processing PCR-based enrichment assays (Note: The provided text contains
  container build logs and error messages rather than CLI help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/forrestzhang/Popera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popera:1.0.3--py_0
stdout: popera.out
