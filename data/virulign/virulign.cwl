cwlVersion: v1.2
class: CommandLineTool
baseCommand: virulign
label: virulign
doc: "The provided text does not contain help information for the tool; it contains
  container build logs and a fatal error message regarding a SIF format conversion
  failure.\n\nTool homepage: https://github.com/rega-cev/virulign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virulign:1.1.1--hf316886_6
stdout: virulign.out
