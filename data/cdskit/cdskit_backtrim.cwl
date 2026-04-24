cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_backtrim
label: cdskit_backtrim
doc: "Backtrim CDS alignments to match trimmed amino acid alignments.\n\nTool homepage:
  https://github.com/kfuku52/cdskit"
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
  - id: trimmed_aa_aln
    type: File
    doc: "PATH to the trimmed amino acid alignment. In\n                        addition
      to this, please specify the untrimmed CDS\n                        alignment
      by --seqfile."
    inputBinding:
      position: 101
      prefix: --trimmed_aa_aln
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
