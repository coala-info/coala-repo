cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx fit_predict
label: metafx_fit_predict
doc: "Machine Learning methods to train classification model based on extracted features
  and immediately apply it to classify new samples\n\nTool homepage: https://github.com/ctlab/metafx"
inputs:
  - id: feature_table
    type: File
    doc: 'file with feature table in tsv format: rows – features, columns – samples
      ("workDir/feature_table.tsv" can be used)'
    inputBinding:
      position: 101
      prefix: --feature-table
  - id: metadata_file
    type: File
    doc: 'tab-separated file with 2 values in each row: <sample>\t<category> ("workDir/samples_categories.tsv"
      can be used)'
    inputBinding:
      position: 101
      prefix: --metadata-file
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of output files in workDir
    default: model
    inputBinding:
      position: 101
      prefix: --name
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: working directory
    default: workDir/
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
stdout: metafx_fit_predict.out
