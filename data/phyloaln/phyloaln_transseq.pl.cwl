cwlVersion: v1.2
class: CommandLineTool
baseCommand: transseq.pl
label: phyloaln_transseq.pl
doc: "Converts sequences between different formats.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: amino_acids
    type:
      - 'null'
      - boolean
    doc: Output amino acids (default).
    inputBinding:
      position: 101
      prefix: -a
  - id: codons
    type:
      - 'null'
      - boolean
    doc: Output codons instead of amino acids.
    inputBinding:
      position: 101
      prefix: -c
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Genome file for annotation.
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input file containing sequences.
    inputBinding:
      position: 101
      prefix: -i
  - id: longest_orf
    type:
      - 'null'
      - boolean
    doc: Output only the longest open reading frame.
    inputBinding:
      position: 101
      prefix: -l
  - id: nucleotides
    type:
      - 'null'
      - boolean
    doc: Output nucleotides.
    inputBinding:
      position: 101
      prefix: -n
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table to use (e.g., '1', '2', '3', '4', '5', '6', '9', 
      '10', '11', '12', '13', '14', '15', '16', '21', '22', '23', '24', '25', 
      '26').
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: Output file to write converted sequences.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
