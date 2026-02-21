cwlVersion: v1.2
class: CommandLineTool
baseCommand: tides-ml
label: tides-ml
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/xxmalcala/TIdeS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tides-ml:1.3.5--pyhdfd78af_0
stdout: tides-ml.out
