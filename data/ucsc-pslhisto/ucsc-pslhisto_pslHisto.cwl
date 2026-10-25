cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslHisto
label: ucsc-pslhisto_pslHisto
doc: "Collect counts on PSL alignments for making histograms.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: what
    type: string
    doc: "What data to collect: alignsPerQuery, coverSpread or idSpread."
    inputBinding:
      position: 1
  - id: in_psl
    type: File
    doc: "Input PSL file."
    inputBinding:
      position: 2
  - id: out_histo
    type: string
    doc: "Output histogram file name."
    inputBinding:
      position: 3
  - id: multi_only
    type:
      - 'null'
      - boolean
    doc: "Omit queries with only one alignment from output."
    inputBinding:
      position: 0
      prefix: "-multiOnly"
  - id: non_zero
    type:
      - 'null'
      - boolean
    doc: "Omit queries with zero values."
    inputBinding:
      position: 0
      prefix: "-nonZero"
outputs:
  - id: histo
    type: File
    doc: "Histogram counts, one line per query."
    outputBinding:
      glob: $(inputs.out_histo)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslhisto:482--h0b57e2e_0
stderr: ucsc-pslhisto_pslHisto.err
