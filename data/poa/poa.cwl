cwlVersion: v1.2
class: CommandLineTool
baseCommand: poa
label: poa
doc: "Partial Order Alignment for multiple sequence alignment\n\nTool homepage: https://github.com/jakecreps/poastal"
inputs:
  - id: matrix_file
    type: File
    doc: Score matrix file (e.g., BLOSUM80)
    inputBinding:
      position: 1
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Read in FASTA sequence file
    inputBinding:
      position: 102
      prefix: -read_fasta
  - id: heaviest_bundle
    type:
      - 'null'
      - boolean
    doc: Generate consensus using heaviest bundle algorithm
    inputBinding:
      position: 102
      prefix: -hb
  - id: msa_file
    type:
      - 'null'
      - File
    doc: Read in MSA alignment file
    inputBinding:
      position: 102
      prefix: -read_msa
  - id: pair_score
    type:
      - 'null'
      - File
    doc: Read in tab-separated file of residue pair scores
    inputBinding:
      position: 102
      prefix: -pair_score
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run in verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: clustal_output
    type:
      - 'null'
      - File
    doc: Write out MSA in Clustal format
    outputBinding:
      glob: $(inputs.clustal_output)
  - id: pir_output
    type:
      - 'null'
      - File
    doc: Write out MSA in PIR format
    outputBinding:
      glob: $(inputs.pir_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/poa:v2.020060928-7-deb_cv1
