cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPResso
label: crispresso_CRISPResso
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error indicating a failure to fetch or
  build the image.\n\nTool homepage: https://github.com/lucapinello/CRISPResso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
stdout: crispresso_CRISPResso.out
