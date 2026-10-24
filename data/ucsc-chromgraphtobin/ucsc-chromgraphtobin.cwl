cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromGraphToBin
label: ucsc-chromgraphtobin
doc: "Make binary version of chromGraph.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_tab
    type: File
    doc: Input chromGraph tab-separated file (chrom, position, value).
    inputBinding:
      position: 1
  - id: out_chrom_graph
    type: string
    doc: Output binary chromGraph file name.
    inputBinding:
      position: 2
outputs:
  - id: output_chrom_graph
    type: File
    doc: Output binary chromGraph file.
    outputBinding:
      glob: $(inputs.out_chrom_graph)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chromgraphtobin:482--h0b57e2e_0
