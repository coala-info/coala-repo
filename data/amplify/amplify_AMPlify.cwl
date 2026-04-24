cwlVersion: v1.2
class: CommandLineTool
baseCommand: AMPlify.py
label: amplify_AMPlify
doc: "Predict whether a sequence is AMP or not. Input sequences should be in fasta
  format. Sequences should be shorter than 201 amino acids long, and should not contain
  amino acids other than the 20 standard ones.\n\nTool homepage: https://github.com/bcgsc/AMPlify"
inputs:
  - id: attention
    type:
      - 'null'
      - string
    doc: Whether to output attention scores, on or off (off by default, 
      optional)
    inputBinding:
      position: 101
      prefix: --attention
  - id: model
    type:
      - 'null'
      - string
    doc: Balanced or imbalanced model (balanced by default, optional)
    inputBinding:
      position: 101
      prefix: --model
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format, txt or tsv (tsv by default, optional)
    inputBinding:
      position: 101
      prefix: --out_format
  - id: seqs
    type: File
    doc: Sequences for prediction, fasta file
    inputBinding:
      position: 101
      prefix: --seqs
  - id: sub_model
    type:
      - 'null'
      - string
    doc: Whether to output sub-model results, on or off (off by default, 
      optional)
    inputBinding:
      position: 101
      prefix: --sub_model
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (optional)
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplify:2.0.1--py36hdfd78af_0
