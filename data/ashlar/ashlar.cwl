cwlVersion: v1.2
class: CommandLineTool
baseCommand: ashlar
label: ashlar
doc: "Alignment by Simultaneous Harmonization of Layered Angiography Images (Note:
  The provided input text contained system error logs rather than help text; no arguments
  could be extracted from the source.)\n\nTool homepage: https://github.com/sorgerlab/ashlar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ashlar:1.19.0--pyhdfd78af_0
stdout: ashlar.out
