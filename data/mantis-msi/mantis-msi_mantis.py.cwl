cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis.py
label: mantis-msi_mantis.py
doc: "A tool for Microsatellite Instability (MSI) detection. Note: The provided help
  text contains only system error logs regarding container execution and does not
  list available command-line arguments.\n\nTool homepage: https://github.com/OSU-SRLab/MANTIS/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis-msi:1.0.5--h4ac6f70_2
stdout: mantis-msi_mantis.py.out
