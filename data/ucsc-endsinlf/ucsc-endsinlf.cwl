cwlVersion: v1.2
class: CommandLineTool
baseCommand: endsInLf
label: ucsc-endsinlf
doc: "Check that last letter in files is end of line. The tool prints a message to
  standard error and exits with status 255 for a file that does not end in a line
  feed.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input file(s) to check.
    inputBinding:
      position: 2
  - id: zero_ok
    type:
      - 'null'
      - boolean
    doc: Accept files of zero length.
    inputBinding:
      position: 1
      prefix: -zeroOk
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Messages about files that do not end in a line feed
stdout: ucsc-endsinlf.out
stderr: ucsc-endsinlf.err
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-endsinlf:377--h199ee4e_0
