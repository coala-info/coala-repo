cwlVersion: v1.2
class: CommandLineTool
baseCommand: tablet_coveragestats.py
label: tablet_coveragestats.py
doc: "A tool for calculating coverage statistics (Note: The provided text contains
  container runtime errors and does not include help or usage information).\n\nTool
  homepage: https://ics.hutton.ac.uk/tablet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tablet:1.17.08.17--0
stdout: tablet_coveragestats.py.out
