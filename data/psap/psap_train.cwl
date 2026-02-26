cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psap
  - train
label: psap_train
doc: "Train a RandomForest classifier for PSAP (Phase Separation Associated Proteins)\n\
  \nTool homepage: https://github.com/vanheeringen-lab/psap"
inputs:
  - id: fasta
    type: File
    doc: Path to peptide fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: labels
    type:
      - 'null'
      - File
    doc: .txt file with llps uniprot ids (positive training labels)
    inputBinding:
      position: 101
      prefix: --labels
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory to store trained RandomForest classifier in json 
      format
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
