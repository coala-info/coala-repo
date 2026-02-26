cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-explorer_prosextract
label: emboss-explorer_prosextract
doc: "Process the PROSITE motif database for use by patmatmotifs\n\nTool homepage:
  http://emboss.open-bio.org/"
inputs:
  - id: prositedir
    type:
      - 'null'
      - Directory
    doc: PROSITE database directory
    inputBinding:
      position: 101
      prefix: -prositedir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_prosextract.out
