cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vendian
label: vmatch_vendian
doc: "Swap the byte order of a binary file of integers (for moving Vmatch index files between machines).

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bytes
    type: int
    doc: "number of bytes per integer"
    inputBinding:
      position: 1
  - id: filename
    type: File
    doc: "binary file to convert"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_vendian.out
