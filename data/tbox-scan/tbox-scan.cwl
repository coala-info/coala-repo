cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbox-scan
label: tbox-scan
doc: "Scan a fasta sequence file for T-boxes and predict specifier & T-box sequence.\n\
  \nTool homepage: https://tbdb.io/"
inputs:
  - id: covariance_model
    type:
      - 'null'
      - int
    doc: "search for T-boxes using different covariance models\n                 \
      \   1: RFAM model (RFAM00230.cm), finds mostly class I transcriptional T-boxes
      (default)\n                    2: Translational Ile (TBDB001.cm), finds mostly
      class II translational T-boxes"
    default: 1
    inputBinding:
      position: 101
      prefix: -m
  - id: infernal_output_file
    type:
      - 'null'
      - File
    doc: save INFERNAL output predictions to .txt file
    default: INFERNAL.txt
    inputBinding:
      position: 101
      prefix: -i
  - id: input_fasta_file
    type: File
    doc: input FASTA file
    inputBinding:
      position: 101
      prefix: -f
  - id: log_file
    type:
      - 'null'
      - File
    doc: save a .txt log file of pipeline output
    inputBinding:
      position: 101
      prefix: -l
  - id: score_cutoff
    type:
      - 'null'
      - int
    doc: score cutoff for INFERNAL model predictions
    default: 15
    inputBinding:
      position: 101
      prefix: -c
  - id: silence_console
    type:
      - 'null'
      - boolean
    doc: silence console output
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: save verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: save final results in file as .csv
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbox-scan:1.0.2--hdfd78af_2
