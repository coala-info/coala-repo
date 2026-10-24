cwlVersion: v1.2
class: CommandLineTool
baseCommand: countChars
label: ucsc-countchars
doc: "Count the number of occurrences of a particular char. The char can either be
  a two digit hexadecimal value or a single letter literal character.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: char
    type: string
    doc: Character to count, a two digit hexadecimal value or a single literal letter.
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Input file(s).
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Count of the character
stdout: ucsc-countchars.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-countchars:482--h0b57e2e_0
