cwlVersion: v1.2
class: CommandLineTool
baseCommand: debwt_transferN
label: debwt_transferN
doc: "A tool for transferring Ns from original sequences to BWT-based representations
  (part of the debwt suite). Note: The provided help text contains only system logs
  and error messages, so no arguments could be extracted.\n\nTool homepage: https://github.com/DixianZhu/deBWT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debwt:1.0.1--h577a1d6_8
stdout: debwt_transferN.out
