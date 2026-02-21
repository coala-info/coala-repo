cwlVersion: v1.2
class: CommandLineTool
baseCommand: PLEK.py
label: plek
doc: "Predictor of Long non-coding RNAs and messenger RNAs based on K-mer scheme\n
  \nTool homepage: https://sourceforge.net/projects/plek"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file or a file containing the paths of FASTA files
    inputBinding:
      position: 101
      prefix: -fasta
  - id: is_list
    type:
      - 'null'
      - int
    doc: Indicate if the input is a list of FASTA files (0 for no, 1 for yes)
    default: 0
    inputBinding:
      position: 101
      prefix: -is_list
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of sequences to be predicted
    default: 200
    inputBinding:
      position: 101
      prefix: -minlength
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 10
    inputBinding:
      position: 101
      prefix: -thread
outputs:
  - id: output
    type: File
    doc: Output file to write the predictions
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
