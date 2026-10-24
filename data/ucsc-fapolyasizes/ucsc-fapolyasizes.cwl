cwlVersion: v1.2
class: CommandLineTool
baseCommand: faPolyASizes
label: ucsc-fapolyasizes
doc: "Get poly A sizes. The output file has four columns: id seqSize tailPolyASize
  headPolyTSize.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input FASTA file to analyze
    inputBinding:
      position: 1
  - id: out_tab
    type: string
    doc: Output tab-separated file name
    inputBinding:
      position: 2
outputs:
  - id: output_tab
    type: File
    doc: Output table with id, seqSize, tailPolyASize and headPolyTSize
    outputBinding:
      glob: $(inputs.out_tab)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fapolyasizes:482--h0b57e2e_0
