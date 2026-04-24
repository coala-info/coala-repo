cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_pad
label: cdskit_pad
doc: "Pad CDS sequences to be multiples of three.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
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
  - id: nopseudo
    type:
      - 'null'
      - boolean
    doc: "Drop sequences that contain stop\n                        codon(s) even
      after padding to 5'- or 3'- terminal."
    inputBinding:
      position: 101
      prefix: --nopseudo
  - id: outseqformat
    type:
      - 'null'
      - string
    doc: "Output sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    inputBinding:
      position: 101
      prefix: --outseqformat
  - id: padchar
    type:
      - 'null'
      - string
    doc: "A character to be used to pad when the\n                        sequence
      length is not multiple of three."
    inputBinding:
      position: 101
      prefix: --padchar
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
