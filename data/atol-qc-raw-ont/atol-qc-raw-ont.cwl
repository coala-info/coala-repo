cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-qc-raw-ont
label: atol-qc-raw-ont
doc: "Quality control for raw Oxford Nanopore Technology (ONT) data (Note: The provided
  text contains system error logs rather than help documentation; no arguments could
  be extracted).\n\nTool homepage: https://github.com/TomHarrop/atol-qc-raw-ont"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-qc-raw-ont:0.1.12--pyhdfd78af_0
stdout: atol-qc-raw-ont.out
