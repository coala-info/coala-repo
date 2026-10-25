cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMapPostChain
label: ucsc-pslmappostchain
doc: "Post genomic pslMap (TransMap) chaining. This takes transcripts that have been mapped via genomic chains and adds back in blocks that did not get included in genomic chains due to complex rearrangements or other issues.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file (output of pslMap)."
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 2
outputs:
  - id: out_file
    type: File
    doc: "Chained PSL file."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmappostchain:482--h0b57e2e_0
stderr: ucsc-pslmappostchain.err
