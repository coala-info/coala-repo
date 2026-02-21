cwlVersion: v1.2
class: CommandLineTool
baseCommand: aaindexextract
label: emboss-lib_aaindexextract
doc: "Extract amino acid index data from AAINDEX (Note: The provided help text contains
  only system error messages regarding container execution and does not list tool-specific
  arguments).\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-lib:v6.6.0dfsg-6-deb_cv1
stdout: emboss-lib_aaindexextract.out
