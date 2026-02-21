cwlVersion: v1.2
class: CommandLineTool
baseCommand: msalign2
label: msalign2
doc: "A tool for mass spectrometry alignment (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: http://www.ms-utils.org/msalign2/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msalign2:1.0--h577a1d6_6
stdout: msalign2.out
