cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx bandage
label: metafx_bandage
doc: "MetaFX bandage module – Machine Learning methods to train classifier and prepare
  for visualisation in Bandage (https://github.com/ctlab/BandageNG)\n\nTool homepage:
  https://github.com/ctlab/metafx"
inputs:
  - id: estimator
    type:
      - 'null'
      - string
    doc: 'classification model: RF – Random Forest, ADA – AdaBoost, GBDT – Gradient
      Boosted Decision Trees'
    inputBinding:
      position: 101
      prefix: --estimator
  - id: feature_dir
    type: Directory
    doc: directory containing folders with contigs for each category, 
      feature_table.tsv and categories_samples.tsv files. Usually, it is workDir
      from other MetaFX modules (unique, stats, colored, metafast, metaspades)
    inputBinding:
      position: 101
      prefix: --feature-dir
  - id: gui
    type:
      - 'null'
      - boolean
    doc: if TRUE opens Bandage GUI and draw images. Does NOT work on servers 
      with command line interface only
    inputBinding:
      position: 101
      prefix: --gui
  - id: max_depth
    type:
      - 'null'
      - int
    doc: maximum depth of decision tree base estimator
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: model
    type:
      - 'null'
      - File
    doc: file with pre-trained classification model, obtained via 'fit' or 'cv' 
      module ("workDir/rf_model.joblib" can be used)
    inputBinding:
      position: 101
      prefix: --model
  - id: n_estimators
    type:
      - 'null'
      - int
    doc: number of estimators in classification model
    inputBinding:
      position: 101
      prefix: --n-estimators
  - id: name
    type:
      - 'null'
      - string
    doc: name of output file with tree model in text format in workDir
    inputBinding:
      position: 101
      prefix: --name
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: working directory
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_bandage.out
