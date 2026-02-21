cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRlungo
label: crisprlungo_CRISPRlungo
doc: "CRISPRlungo is a tool for analyzing long-read CRISPR screen data. (Note: The
  provided help text contains only system error logs and no usage information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/pinellolab/CRISPRlungo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprlungo:0.1.14--py310h086e186_0
stdout: crisprlungo_CRISPRlungo.out
