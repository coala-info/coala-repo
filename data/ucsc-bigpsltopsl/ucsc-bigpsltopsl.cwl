cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigPslToPsl
label: ucsc-bigpsltopsl
doc: "Convert bigPsl files to psl format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: big_psl
    type: File
    doc: Input bigPsl file
    inputBinding:
      position: 1
outputs:
  - id: out_psl
    type: File
    doc: Output psl file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigpsltopsl:482--h0b57e2e_0
