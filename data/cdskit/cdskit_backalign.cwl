cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cdskit
  - backalign
label: cdskit_backalign
doc: "Backalign CDS sequences to their corresponding aligned amino acid sequences.\n\
  \nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: aa_aln
    type: File
    doc: "PATH to aligned amino acid sequences. In\n                        addition
      to this, please specify unaligned CDS by\n                        --seqfile."
    inputBinding:
      position: 101
      prefix: --aa_aln
  - id: codontable
    type:
      - 'null'
      - int
    doc: "Codon table ID. The standard code is \"1\".\n                        See
      here for details: https://www.ncbi.nlm.nih.gov/Tax\n                       \
      \ onomy/Utils/wprintgc.cgi"
    inputBinding:
      position: 101
      prefix: --codontable
  - id: inseqformat
    type:
      - 'null'
      - string
    doc: "Input sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    inputBinding:
      position: 101
      prefix: --inseqformat
  - id: outseqformat
    type:
      - 'null'
      - string
    doc: "Output sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    inputBinding:
      position: 101
      prefix: --outseqformat
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --seqfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output sequence file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
