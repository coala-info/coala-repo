cwlVersion: v1.2
class: CommandLineTool
baseCommand: diapysef_histogram_swath_overlay.py
label: diapysef_histogram_swath_overlay.py
doc: "A tool from the diapysef package (description not available in the provided
  logs).\n\nTool homepage: https://github.com/Roestlab/dia-pasef"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
stdout: diapysef_histogram_swath_overlay.py.out
