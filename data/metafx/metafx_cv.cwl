cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx cv
label: metafx_cv
doc: "Machine Learning methods to train classification model based on extracted features
  and check accuracy via cross-validation\n\nTool homepage: https://github.com/ctlab/metafx"
inputs:
  - id: feature_table
    type: File
    doc: 'file with feature table in tsv format: rows – features, columns – samples
      ("workDir/feature_table.tsv" can be used)'
    inputBinding:
      position: 101
      prefix: --feature-table
  - id: grid_search
    type:
      - 'null'
      - boolean
    doc: if TRUE, perform grid search of optimal parameters for classification 
      model
    inputBinding:
      position: 101
      prefix: --grid
  - id: metadata_file
    type: File
    doc: 'tab-separated file with 2 values in each row: <sample>\t<category> ("workDir/samples_categories.tsv"
      can be used)'
    inputBinding:
      position: 101
      prefix: --metadata-file
  - id: model_name
    type:
      - 'null'
      - string
    doc: name of output trained model in workDir
    inputBinding:
      position: 101
      prefix: --name
  - id: n_splits
    type:
      - 'null'
      - int
    doc: number of folds in cross-validation. Must be at least 2.
    inputBinding:
      position: 101
      prefix: --n-splits
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
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
stdout: metafx_cv.out
