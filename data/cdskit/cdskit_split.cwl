cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_split
label: cdskit_split
doc: "Split CDS sequences into multiple files based on sequence identifiers.\n\nTool
  homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: inseqformat
    type:
      - 'null'
      - string
    doc: "Input sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    default: fasta
    inputBinding:
      position: 101
      prefix: --inseqformat
  - id: outseqformat
    type:
      - 'null'
      - string
    doc: "Output sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    default: fasta
    inputBinding:
      position: 101
      prefix: --outseqformat
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output prefix PATH. If this is INFILE and --outfile is set, --outfile 
      is used as the prefix.
    default: INFILE
    inputBinding:
      position: 101
      prefix: --prefix
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    default: '-'
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
