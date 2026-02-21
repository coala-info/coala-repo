cwlVersion: v1.2
class: CommandLineTool
baseCommand: aaindexextract
label: emboss-explorer_aaindexextract
doc: "Extract amino acid index data (Note: The provided help text contains system
  error messages and does not list specific arguments).\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_aaindexextract.out
