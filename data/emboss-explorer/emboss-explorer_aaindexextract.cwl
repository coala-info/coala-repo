cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-explorer_aaindexextract
label: emboss-explorer_aaindexextract
doc: "Extract amino acid property data from AAINDEX\n\nTool homepage: http://emboss.open-bio.org/"
inputs:
  - id: infile
    type: File
    doc: AAINDEX database file
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_aaindexextract.out
