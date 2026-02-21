cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutesv-ol
label: cutesv-ol
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains error logs related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/120L022331/cuteSV-OL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
stdout: cutesv-ol.out
