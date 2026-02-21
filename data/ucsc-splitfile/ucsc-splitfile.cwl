cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitFile
label: ucsc-splitfile
doc: "Split a file into pieces of a given size.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input file to be split.
    inputBinding:
      position: 1
  - id: lines_per_file
    type: int
    doc: The number of lines per output chunk.
    inputBinding:
      position: 2
  - id: out_root
    type: string
    doc: The prefix/root name for the output files.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-splitfile:482--h0b57e2e_0
stdout: ucsc-splitfile.out
