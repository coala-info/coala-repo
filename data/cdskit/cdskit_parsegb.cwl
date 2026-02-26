cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_parsegb
label: cdskit_parsegb
doc: "Parse GenBank files.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: extract_cds
    type:
      - 'null'
      - string
    doc: Whether to extract the CDS feature.
    default: yes
    inputBinding:
      position: 101
      prefix: --extract_cds
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
  - id: list_seqname_keys
    type:
      - 'null'
      - string
    doc: Listing the keys (and values) available for --seqnamefmt.
    default: no
    inputBinding:
      position: 101
      prefix: --list_seqname_keys
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
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: seqnamefmt
    type:
      - 'null'
      - string
    doc: Underline-separated list of sequence name elements. Use 
      --list_seqname_keys to browse available values.
    default: organism_accessions
    inputBinding:
      position: 101
      prefix: --seqnamefmt
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
