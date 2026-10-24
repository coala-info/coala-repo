cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastToPsl
label: ucsc-blasttopsl
doc: "Convert blast alignments to PSLs. Output only results of last round from PSI BLAST.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: blast_output
    type: File
    doc: "Input BLAST output file"
    inputBinding:
      position: 1
  - id: psl_output
    type: string
    doc: "Name of the output PSL file"
    inputBinding:
      position: 2
  - id: scores
    type:
      - 'null'
      - string
    doc: "Write score information to this file. Format is: strands qName qStart qEnd tName tStart tEnd bitscore eVal"
    inputBinding:
      position: 101
      prefix: -scores=
      separate: false
  - id: verbose
    type:
      - 'null'
      - int
    doc: "n >= 3 prints each line of file after parsing; n >= 4 dumps the result of each query"
    inputBinding:
      position: 101
      prefix: -verbose=
      separate: false
  - id: e_val
    type:
      - 'null'
      - string
    doc: "E-value threshold to filter results (integer, double or 1e-10). Default is no filter"
    inputBinding:
      position: 101
      prefix: -eVal=
      separate: false
  - id: pslx
    type:
      - 'null'
      - boolean
    doc: "Create PSLX output (includes sequences for blocks)"
    inputBinding:
      position: 101
      prefix: -pslx
outputs:
  - id: out_psl_output
    type: File
    doc: "Output PSL file"
    outputBinding:
      glob: $(inputs.psl_output)
  - id: out_scores
    type: ['null', File]
    doc: "Score information file"
    outputBinding:
      glob: $(inputs.scores)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blasttopsl:482--h0b57e2e_0
