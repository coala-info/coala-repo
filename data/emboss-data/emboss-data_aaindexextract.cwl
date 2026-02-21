cwlVersion: v1.2
class: CommandLineTool
baseCommand: aaindexextract
label: emboss-data_aaindexextract
doc: "Extract amino acid index data from AAINDEX (Note: The provided help text contains
  only system error messages and no tool-specific usage information).\n\nTool homepage:
  http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-data:v6.6.0dfsg-7-deb_cv1
stdout: emboss-data_aaindexextract.out
