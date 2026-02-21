cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypore
label: pypore
doc: "The provided text does not contain help information for the tool 'pypore'. It
  appears to be a log of a failed container build process.\n\nTool homepage: http://parkin.github.io/pypore/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypore:0.0.6.dev20161116235131--py27h24bf2e0_1
stdout: pypore.out
