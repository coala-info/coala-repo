cwlVersion: v1.2
class: CommandLineTool
baseCommand: plncpro_predict
label: plncpro_predict
doc: "This script classifies transcripts as coding or non coding transcripts\n\nTool
  homepage: https://github.com/urmi-21/PLncPRO"
inputs:
  - id: blast_database
    type:
      - 'null'
      - Directory
    doc: path to blast database
    inputBinding:
      position: 101
      prefix: -d
  - id: blast_output_file
    type:
      - 'null'
      - File
    doc: path to blast output for input file
    inputBinding:
      position: 101
      prefix: --blastres
  - id: cleanup_intermediate_files
    type:
      - 'null'
      - boolean
    doc: clean up intermediate files
    inputBinding:
      position: 101
      prefix: -r
  - id: input_sequences_file
    type:
      - 'null'
      - File
    doc: path to file containing input sequences
    inputBinding:
      position: 101
      prefix: -i
  - id: labels_file
    type:
      - 'null'
      - File
    doc: path to the files containg labels(this outputs performance of the 
      classifier)
    inputBinding:
      position: 101
      prefix: -l
  - id: min_len
    type:
      - 'null'
      - int
    doc: specifiy min_length to filter input files
    inputBinding:
      position: 101
      prefix: --min_len
  - id: model_file
    type:
      - 'null'
      - File
    doc: path to the model file
    inputBinding:
      position: 101
      prefix: -m
  - id: no_blast
    type:
      - 'null'
      - boolean
    doc: Don't use blast features
    inputBinding:
      position: 101
      prefix: --noblast
  - id: no_ff
    type:
      - 'null'
      - boolean
    doc: Don't use framefinder features
    inputBinding:
      position: 101
      prefix: --no_ff
  - id: qcov_hsp
    type:
      - 'null'
      - int
    doc: specify qcov parameter for blast
    inputBinding:
      position: 101
      prefix: --qcov_hsp
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more messages
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_prediction_file
    type:
      - 'null'
      - File
    doc: output file name to store prediction results
    outputBinding:
      glob: $(inputs.output_prediction_file)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory name to store all results
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
