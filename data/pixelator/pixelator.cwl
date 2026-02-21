cwlVersion: v1.2
class: CommandLineTool
baseCommand: pixelator
label: pixelator
doc: "The provided text does not contain help information or usage instructions; it
  contains environment info and a fatal error regarding a container manifest.\n\n
  Tool homepage: https://github.com/PixelgenTechnologies/pixelator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pixelator:0.20.1--pyhdfd78af_0
stdout: pixelator.out
