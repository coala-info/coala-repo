cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigPslToPsl
label: ucsc-bigpsltopsl
doc: "Convert bigPsl file to psl.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: big_psl
    type: File
    doc: "Input bigPsl (bigBed) file"
    inputBinding:
      position: 1
  - id: output_psl
    type: string
    doc: "Name of the output PSL file"
    inputBinding:
      position: 2
  - id: collapse_strand
    type:
      - 'null'
      - boolean
    doc: "If target strand is '+', don't output it"
    inputBinding:
      position: 101
      prefix: -collapseStrand
outputs:
  - id: out_output_psl
    type: File
    doc: "Output PSL file"
    outputBinding:
      glob: $(inputs.output_psl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigpsltopsl:482--h0b57e2e_0
