cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedGraphPack
label: ucsc-bedgraphpack
doc: "Pack together adjacent records representing same value. The input needs to be
  sorted by chrom and this is checked.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bedgraph
    type: File
    doc: Input bedGraph file, sorted by chrom.
    inputBinding:
      position: 1
  - id: out_bedgraph
    type: string
    doc: Name of the output bedGraph file.
    inputBinding:
      position: 2
outputs:
  - id: output_bedgraph
    type: File
    doc: Packed bedGraph file.
    outputBinding:
      glob: $(inputs.out_bedgraph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgraphpack:482--h0b57e2e_0
