cwlVersion: v1.2
class: CommandLineTool
baseCommand: gammapy
label: gammapy
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding container image
  acquisition (no space left on device).\n\nTool homepage: https://github.com/gammapy/gammapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gammapy:1.0
stdout: gammapy.out
