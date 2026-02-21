cwlVersion: v1.2
class: CommandLineTool
baseCommand: sweed
label: sweed
doc: "SweeD (Selective Sweep Detector) is a tool for detecting selective sweeps in
  genome-wide data. Note: The provided help text contains only container engine error
  logs and does not list specific command-line arguments.\n\nTool homepage: https://github.com/alachins/sweed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sweed:v3.2.1dfsg-1-deb_cv1
stdout: sweed.out
