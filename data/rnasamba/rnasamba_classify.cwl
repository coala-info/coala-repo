cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasamba classify
label: rnasamba_classify
doc: "Classify sequences from a input FASTA file.\n\nTool homepage: https://github.com/apcamargo/RNAsamba"
inputs:
  - id: output_file
    type: File
    doc: output TSV file containing the results of the classification.
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: input FASTA file containing transcript sequences.
    inputBinding:
      position: 2
  - id: weights
    type:
      type: array
      items: File
    doc: input HDF5 file(s) containing weights of a trained RNAsamba network (if
      more than a file is provided, an ensembling of the models will be 
      performed).
    inputBinding:
      position: 3
  - id: verbose
    type:
      - 'null'
      - int
    doc: print the progress of the classification. 0 = silent, 1 = current step.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: protein_fasta
    type:
      - 'null'
      - File
    doc: output FASTA file containing translated sequences for the predicted 
      coding ORFs.
    outputBinding:
      glob: $(inputs.protein_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasamba:0.2.5--py36h91eb985_1
