cwlVersion: v1.2
class: CommandLineTool
baseCommand: endsInLf
label: ucsc-endsinlf
doc: "Check if a file ends in a line feed (newline). This is a utility from the UCSC
  Genome Browser toolset.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: filename
    type: File
    doc: The file to check for a trailing line feed.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-endsinlf:377--h199ee4e_0
stdout: ucsc-endsinlf.out
