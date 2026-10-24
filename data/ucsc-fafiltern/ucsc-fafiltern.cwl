cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFilterN
label: ucsc-fafiltern
doc: "Get rid of sequences with too many N's.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 10
  - id: out_fa
    type: string
    doc: Output fasta file name
    inputBinding:
      position: 11
  - id: max_percent_n
    type: double
    doc: Maximum percent of N's allowed in a sequence. Must start with a digit.
    inputBinding:
      position: 12
  - id: out
    type:
      - 'null'
      - File
    doc: RepeatMasker .out file (in.fa.out); the N content of each sequence is then
      taken from the ranges listed in it.
    inputBinding:
      position: 1
      prefix: -out=
      separate: false
  - id: uniq
    type:
      - 'null'
      - File
    doc: PSL file of sequences aligned to themselves (self.psl); a sequence that overlaps
      an already written sequence is removed.
    inputBinding:
      position: 2
      prefix: -uniq=
      separate: false
outputs:
  - id: output_fa
    type: File
    doc: Output fasta file without the sequences that have too many N's
    outputBinding:
      glob: $(inputs.out_fa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafiltern:482--h0b57e2e_0
