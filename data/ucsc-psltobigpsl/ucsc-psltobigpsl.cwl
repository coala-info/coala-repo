cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToBigPsl
label: ucsc-psltobigpsl
doc: "Convert PSL to bigPsl input (BED format with extra fields). The result must be
  sorted and then converted with bedToBigBed (-type=bed12+13 -tab -as=bigPsl.as).\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: out_bed
    type: string
    doc: Output bigPsl input file name (use "stdout" to write to standard output).
    inputBinding:
      position: 11
  - id: cds
    type:
      - 'null'
      - File
    doc: Tab-separated columns with the qName and a GenBank style one-based CDS
      (e.g. 475..1731, <1..354).
    inputBinding:
      position: 1
      prefix: -cds=
      separate: false
  - id: fa
    type:
      - 'null'
      - File
    doc: FASTA file with the query sequences.
    inputBinding:
      position: 2
      prefix: -fa=
      separate: false
outputs:
  - id: big_psl_input
    type: File
    doc: Output bigPsl input file (BED with extra fields).
    outputBinding:
      glob: $(inputs.out_bed)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobigpsl:482--h0b57e2e_0
