cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMrnaCover
label: ucsc-pslmrnacover
doc: "Make histogram of coverage percentage of mRNA in psl.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: mrna_psl
    type: File
    doc: "PSL file of mRNA alignments."
    inputBinding:
      position: 1
  - id: mrna_fa
    type: File
    doc: "FASTA file of the mRNAs."
    inputBinding:
      position: 2
  - id: min_size
    type:
      - 'null'
      - int
    doc: "Minimum size of mRNA considered (default 100)."
    inputBinding:
      position: 0
      prefix: "-minSize="
      separate: false
  - id: list_zero
    type:
      - 'null'
      - string
    doc: "List accessions that do not align in this file."
    inputBinding:
      position: 0
      prefix: "-listZero="
      separate: false
outputs:
  - id: zero_list
    type:
      - 'null'
      - File
    doc: "Accessions that do not align."
    outputBinding:
      glob: $(inputs.list_zero)
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmrnacover:482--h0b57e2e_0
stdout: ucsc-pslmrnacover.out
stderr: ucsc-pslmrnacover.err
