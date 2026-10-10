cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - predict
label: metafx_predict
doc: "Machine Learning methods to classify new samples based on pre-trained model\n\nTool homepage: https://github.com/ctlab/metafx"
inputs:
  - id: feature_table
    type: File
    doc: "file with feature table in tsv format: rows - features, columns - samples (\"workDir/feature_table.tsv\" can be used)"
    inputBinding:
      position: 101
      prefix: --feature-table
  - id: model
    type: File
    doc: "file with pre-trained classification model, obtained via 'fit' or 'cv' module (\"workDir/model.joblib\" can be used)"
    inputBinding:
      position: 101
      prefix: --model
  - id: estimator
    type: ['null', string]
    doc: "classification model: RF - scikit-learn Random Forest, XGB - XGBoost, Torch - PyTorch neural network. The shell wrapper passes this value to its Python script by position, so RF is always sent when nothing else is chosen [default: RF]"
    default: RF
    inputBinding:
      position: 101
      prefix: --estimator
  - id: metadata_file
    type: ['null', File]
    doc: "tab-separated file with 2 values in each row: <sample>\\t<category> (\"workDir/samples_categories.tsv\" can be used) to check accuracy of predictions [optional, default: None]"
    inputBinding:
      position: 101
      prefix: --metadata-file
  - id: output_name
    type: ['null', string]
    doc: "name of output file with samples predicted labels in workDir [default: predictions]"
    inputBinding:
      position: 101
      prefix: --name
  - id: work_dir
    type: string
    doc: "working directory (created by the tool, it must not exist before the run)"
    default: workDir
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: results_dir
    type: Directory
    doc: "Working directory with the results"
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_predict.out
