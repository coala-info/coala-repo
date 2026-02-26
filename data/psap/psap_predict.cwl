cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psap
  - predict
label: psap_predict
doc: "Predict protein phase separation potential using the PSAP classifier.\n\nTool
  homepage: https://github.com/vanheeringen-lab/psap"
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
  - id: model
    type:
      - 'null'
      - File
    doc: Path to RandomForest model in json format
    inputBinding:
      position: 101
      prefix: --model
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory for psap prediction results
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
