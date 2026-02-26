cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_hammer
label: cdskit_hammer
doc: "Hammer sequences to remove gaps and ambiguous bases.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: codontable
    type:
      - 'null'
      - int
    doc: "Codon table ID. The standard code is \"1\".\n                        See
      here for details: https://www.ncbi.nlm.nih.gov/Tax\n                       \
      \ onomy/Utils/wprintgc.cgi"
    default: 1
    inputBinding:
      position: 101
      prefix: --codontable
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
  - id: nail
    type:
      - 'null'
      - string
    doc: "Threshold number of \"nail sequences\" to\n                        hammer
      down. Codon columns are removed if there are no\n                        more
      than this number of non-missing sequences. \"all\"\n                       \
      \ generates a completely no-gap output."
    default: '4'
    inputBinding:
      position: 101
      prefix: --nail
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
  - id: prevent_gap_only
    type:
      - 'null'
      - string
    doc: "Whether to relax (decrease) --nail when a\n                        gap-only
      sequence is generated."
    default: yes
    inputBinding:
      position: 101
      prefix: --prevent_gap_only
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
