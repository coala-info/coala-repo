cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmagick backtrans-align
label: seqmagick_backtrans-align
doc: "Given a protein alignment and unaligned nucleotides, align the nucleotides using
  the protein alignment. Protein and nucleotide sequence files must contain the same
  number of sequences, in the same order, with the same IDs.\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs:
  - id: protein_align
    type: File
    doc: Protein Alignment
    inputBinding:
      position: 1
  - id: nucl_align
    type: File
    doc: FASTA Alignment
    inputBinding:
      position: 2
  - id: fail_action
    type:
      - 'null'
      - string
    doc: Action to take on an ambiguous codon
    inputBinding:
      position: 103
      prefix: --fail-action
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table to use.
    inputBinding:
      position: 103
      prefix: --translation-table
outputs:
  - id: destination_file
    type:
      - 'null'
      - File
    doc: Output destination.
    outputBinding:
      glob: $(inputs.destination_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
