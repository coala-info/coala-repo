cwlVersion: v1.2
class: CommandLineTool
baseCommand: proovframe_fix
label: proovframe_fix
doc: "Fixes frameshifts in sequences based on Diamond output.\n\nTool homepage: https://github.com/thackl/proovframe"
inputs:
  - id: seqs_fa
    type: File
    doc: Input FASTA file of sequences
    inputBinding:
      position: 1
  - id: diamond_tsv
    type: File
    doc: Diamond output TSV file (long-reads mode blastx 6 with extra cigar 
      columns)
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show debug messages
    inputBinding:
      position: 103
      prefix: --debug
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code table, sets stop codons
    inputBinding:
      position: 103
      prefix: --genetic-code
  - id: no_stop_masking
    type:
      - 'null'
      - boolean
    doc: disable internal stop codon masking
    inputBinding:
      position: 103
      prefix: --no-stop-masking
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: write to this file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
