cwlVersion: v1.2
class: CommandLineTool
baseCommand: crisprme
label: crisprme
doc: "CRISPRme: A tool for comprehensive personalized CRISPR off-target assessment
  (Note: The provided help text contains system error logs and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/samuelecancellieri/CRISPRme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
stdout: crisprme.out
