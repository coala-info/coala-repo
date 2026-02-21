cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpra-data-access-portal
label: mpra-data-access-portal
doc: "A tool for accessing MPRA (Massively Parallel Reporter Assay) data.\n\nTool
  homepage: https://mpra.gs.washington.edu/satMutMPRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpra-data-access-portal:0.1.10--hdfd78af_0
stdout: mpra-data-access-portal.out
