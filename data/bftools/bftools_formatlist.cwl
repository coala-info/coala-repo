cwlVersion: v1.2
class: CommandLineTool
baseCommand: formatlist
label: bftools_formatlist
doc: "List the image formats Bio-Formats supports, with the read/write support and
  file extensions of each.\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: html
    type:
      - 'null'
      - boolean
    doc: show formats in an HTML table
    inputBinding:
      position: 101
      prefix: -html
  - id: txt
    type:
      - 'null'
      - boolean
    doc: show formats in plaintext (default)
    inputBinding:
      position: 101
      prefix: -txt
  - id: xml
    type:
      - 'null'
      - boolean
    doc: show formats as XML data
    inputBinding:
      position: 101
      prefix: -xml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_formatlist.out
