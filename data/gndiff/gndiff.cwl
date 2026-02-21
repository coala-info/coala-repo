cwlVersion: v1.2
class: CommandLineTool
baseCommand: gndiff
label: gndiff
doc: "The provided text does not contain help information or usage instructions for
  gndiff. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/gnames/gndiff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gndiff:0.3.0--he881be0_1
stdout: gndiff.out
