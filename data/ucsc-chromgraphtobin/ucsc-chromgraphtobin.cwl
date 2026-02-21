cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromGraphToBin
label: ucsc-chromgraphtobin
doc: "Converts a chromGraph format file to binary format for use with the chromGraphData
  and chromGraphView tools.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input chromGraph file (tab-separated format with chrom, pos, value).
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: Output binary file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chromgraphtobin:482--h0b57e2e_0
