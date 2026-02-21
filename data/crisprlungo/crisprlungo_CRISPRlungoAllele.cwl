cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CRISPRlungoAllele
label: crisprlungo_CRISPRlungoAllele
doc: "CRISPRlungoAllele tool (Note: The provided help text contains system error logs
  rather than usage information, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/pinellolab/CRISPRlungo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprlungo:0.1.14--py310h086e186_0
stdout: crisprlungo_CRISPRlungoAllele.out
