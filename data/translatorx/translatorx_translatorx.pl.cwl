cwlVersion: v1.2
class: CommandLineTool
baseCommand: translatorx_translatorx.pl
label: translatorx_translatorx.pl
doc: "TranslatorX is a tool to align nucleotide sequences based on their amino acid
  translation.\n\nTool homepage: http://pc16141.mncn.csic.es/"
inputs:
  - id: exclude_sequences
    type:
      - 'null'
      - File
    doc: File containing names of sequences to be excluded
    inputBinding:
      position: 101
      prefix: -e
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: 'Genetic code table number (default 1: Standard)'
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type: File
    doc: Input file (FASTA format) containing nucleotide sequences
    inputBinding:
      position: 101
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: [fasta|phylip|clustal]'
    inputBinding:
      position: 101
      prefix: -w
  - id: protein_alignment_program
    type:
      - 'null'
      - string
    doc: 'Protein alignment program: [mafft|muscle|clustal|t_coffee]'
    inputBinding:
      position: 101
      prefix: -p
  - id: trim_alignment
    type:
      - 'null'
      - boolean
    doc: Trim the alignment using GBlocks
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translatorx:1.1--pl5.22.0_0
