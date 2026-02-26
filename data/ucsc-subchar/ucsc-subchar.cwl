cwlVersion: v1.2
class: CommandLineTool
baseCommand: subChar
label: ucsc-subchar
doc: "Substitute one character for another in one or more files.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: old_char
    type: string
    doc: The character to be replaced.
    inputBinding:
      position: 1
  - id: new_char
    type: string
    doc: The character to substitute in.
    inputBinding:
      position: 2
  - id: files
    type:
      type: array
      items: File
    doc: The file(s) to process.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-subchar:482--h0b57e2e_0
stdout: ucsc-subchar.out
