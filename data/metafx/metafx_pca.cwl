cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - pca
label: metafx_pca
doc: "PCA dimensionality reduction and visualisation of samples based on extracted features\n\nTool homepage: https://github.com/ctlab/metafx"
inputs:
  - id: feature_table
    type: File
    doc: "file with feature table in tsv format: rows - features, columns - samples (\"workDir/feature_table.tsv\" can be used)"
    inputBinding:
      position: 101
      prefix: --feature-table
  - id: metadata_file
    type: ['null', File]
    doc: "tab-separated file with 2 values in each row: <sample>\\t<category> (\"workDir/samples_categories.tsv\" can be used) [optional, default: None]"
    inputBinding:
      position: 101
      prefix: --metadata-file
  - id: output_name
    type: ['null', string]
    doc: "name of output image in workDir [optional, default: pca]"
    inputBinding:
      position: 101
      prefix: --name
  - id: show
    type: ['null', boolean]
    doc: "if TRUE print samples' names on plot"
    inputBinding:
      position: 101
      prefix: --show
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
stdout: metafx_pca.out
