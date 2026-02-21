cwlVersion: v1.2
class: CommandLineTool
baseCommand: mira-rfam-12s-rrna
label: mira-rfam-12s-rrna
doc: "A tool for RFAM 12S rRNA analysis. Note: The provided text contains container
  runtime error messages rather than command-line help documentation.\n\nTool homepage:
  https://github.com/DrMicrobit/mira"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mira-rfam-12s-rrna:v4.9.6-4-deb_cv1
stdout: mira-rfam-12s-rrna.out
