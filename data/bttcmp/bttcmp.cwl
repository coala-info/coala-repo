cwlVersion: v1.2
class: CommandLineTool
baseCommand: bttcmp
label: bttcmp
doc: "Compare two btt (Block Trace Tool) output files.\n\nTool homepage: https://github.com/liaochenlanruo/BTTCMP/blob/master/README.md"
inputs:
  - id: file1
    type: File
    doc: First btt output file to compare
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second btt output file to compare
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bttcmp:1.0.3--0
stdout: bttcmp.out
