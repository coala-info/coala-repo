cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_mask
label: cdskit_mask
doc: "Masks codons in a sequence file based on specified criteria.\n\nTool homepage:
  https://github.com/kfuku52/cdskit"
inputs:
  - id: ambiguouscodon
    type:
      - 'null'
      - string
    doc: "Mask ambiguous codons. e.g., \"AAN\", which\n                        may
      code Asn or Lys in the standard genetic code."
    inputBinding:
      position: 101
      prefix: --ambiguouscodon
  - id: codontable
    type:
      - 'null'
      - int
    doc: "Codon table ID. The standard code is \"1\".\n                        See
      here for details: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi"
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
  - id: maskchar
    type:
      - 'null'
      - string
    doc: A character to be used to mask codons.
    inputBinding:
      position: 101
      prefix: --maskchar
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
  - id: stopcodon
    type:
      - 'null'
      - string
    doc: Mask stop codons.
    inputBinding:
      position: 101
      prefix: --stopcodon
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
