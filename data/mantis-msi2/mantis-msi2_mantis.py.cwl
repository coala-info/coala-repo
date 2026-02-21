cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis.py
label: mantis-msi2_mantis.py
doc: "MANTIS (Microsatellite Analysis for Normal-Tumor Instability) is a tool for
  detecting microsatellite instability in paired tumor-normal samples.\n\nTool homepage:
  https://github.com/nh13/MANTIS2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis-msi2:2.0.0--h9948957_3
stdout: mantis-msi2_mantis.py.out
