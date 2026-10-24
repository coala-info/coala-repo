cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromGraphFromBin
label: ucsc-chromgraphfrombin
doc: "Convert chromGraph binary to ascii format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chrom_graph
    type: File
    doc: Input binary chromGraph file.
    inputBinding:
      position: 1
  - id: out_tab
    type: string
    doc: Output tab-separated file name.
    inputBinding:
      position: 2
  - id: chrom
    type:
      - 'null'
      - string
    doc: Restrict output to a single chromosome, for example chrX.
    inputBinding:
      position: 101
      prefix: -chrom=
      separate: false
outputs:
  - id: output_tab
    type: File
    doc: Output tab-separated chromGraph text file.
    outputBinding:
      glob: $(inputs.out_tab)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chromgraphfrombin:482--h0b57e2e_0
