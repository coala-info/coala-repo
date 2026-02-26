cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaprot predict
label: rnaprot_predict
doc: "Predict binding sites on longer sequences using moving window predictions\n\n\
  Tool homepage: https://github.com/BackofenLab/RNAProt"
inputs:
  - id: input_folder
    type: Directory
    doc: Input prediction data folder (output of rnaprot gp)
    inputBinding:
      position: 101
      prefix: --in
  - id: mode
    type:
      - 'null'
      - int
    doc: Define prediction mode. (1) predict whole sites, (2) predict binding 
      sites on longer sequences using moving window predictions
    default: 1
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_folder
    type: string
    doc: Prediction results output folder
    inputBinding:
      position: 101
      prefix: --out
  - id: plot_format
    type:
      - 'null'
      - int
    doc: 'Plotting format of top window profiles. 1: png, 2: pdf'
    default: 1
    inputBinding:
      position: 101
      prefix: --plot-format
  - id: plot_top_profiles
    type:
      - 'null'
      - boolean
    doc: Plot top window profiles
    default: false
    inputBinding:
      position: 101
      prefix: --plot-top-profiles
  - id: site_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide site ID(s) on which to predict (e.g. --site-id site_id1 
      site_id2). By default predict on all --in sites
    inputBinding:
      position: 101
      prefix: --site-id
  - id: threshold_level
    type:
      - 'null'
      - int
    doc: 'Define site score threshold level for reporting peak regions in --mode 2
      (window prediction). 1: relaxed, 2: standard, 3: strict'
    default: 2
    inputBinding:
      position: 101
      prefix: --thr
  - id: train_input_folder
    type: Directory
    doc: Input model training folder containing model file and parameters 
      (output of rnaprot train)
    inputBinding:
      position: 101
      prefix: --train-in
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
stdout: rnaprot_predict.out
