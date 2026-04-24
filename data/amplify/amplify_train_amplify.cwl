cwlVersion: v1.2
class: CommandLineTool
baseCommand: train_amplify.py
label: amplify_train_amplify
doc: "AMPlify v2.0.0 training. Given training sets with two labels: AMP and non-AMP,
  train the AMP prediction model.\n\nTool homepage: https://github.com/bcgsc/AMPlify"
inputs:
  - id: amp_te
    type:
      - 'null'
      - File
    doc: Test AMP set, fasta file (optional)
    inputBinding:
      position: 101
      prefix: -amp_te
  - id: amp_tr
    type: File
    doc: Training AMP set, fasta file
    inputBinding:
      position: 101
      prefix: -amp_tr
  - id: model_name
    type: string
    doc: File name of trained model weights
    inputBinding:
      position: 101
      prefix: -model_name
  - id: non_amp_te
    type:
      - 'null'
      - File
    doc: Test non-AMP set, fasta file (optional)
    inputBinding:
      position: 101
      prefix: -non_amp_te
  - id: non_amp_tr
    type: File
    doc: Training non-AMP set, fasta file
    inputBinding:
      position: 101
      prefix: -non_amp_tr
  - id: sample_ratio
    type:
      - 'null'
      - string
    doc: Whether the training set is balanced or not (balanced by default, 
      optional)
    inputBinding:
      position: 101
      prefix: -sample_ratio
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplify:2.0.1--py36hdfd78af_0
