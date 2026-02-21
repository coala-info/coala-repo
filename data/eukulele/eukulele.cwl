cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukulele
label: eukulele
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/AlexanderLabWHOI/EUKulele"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukulele:2.1.2--pyhdfd78af_0
stdout: eukulele.out
