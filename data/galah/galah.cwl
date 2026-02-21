cwlVersion: v1.2
class: CommandLineTool
baseCommand: galah
label: galah
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure (no space left on device).\n\nTool homepage: https://github.com/wwood/galah"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galah:0.4.2--hc1c3326_2
stdout: galah.out
