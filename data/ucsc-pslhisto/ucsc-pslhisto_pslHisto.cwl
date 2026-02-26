cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslHisto
label: ucsc-pslhisto_pslHisto
doc: "Collect counts on PSL alignments for making histograms.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: what
    type: string
    doc: determines what data to collect
    inputBinding:
      position: 1
  - id: in_psl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 2
  - id: multi_only
    type:
      - 'null'
      - boolean
    doc: omit queries with only one alignment from output.
    inputBinding:
      position: 103
      prefix: -multiOnly
  - id: non_zero
    type:
      - 'null'
      - boolean
    doc: omit queries with zero values.
    inputBinding:
      position: 103
      prefix: -nonZero
outputs:
  - id: out_histo
    type: File
    doc: Output histogram file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslhisto:482--h0b57e2e_0
