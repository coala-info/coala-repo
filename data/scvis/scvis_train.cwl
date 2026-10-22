cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scvis
  - train
label: scvis_train
doc: "Train a scVIS model.\n\nTool homepage: https://bitbucket.org/jerry00/scvis-dev/commits/all"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to a yaml format configuration file
    inputBinding:
      position: 101
      prefix: --config_file
  - id: data_label_file
    type:
      - 'null'
      - File
    doc: Just used for colouring scatter plots
    inputBinding:
      position: 101
      prefix: --data_label_file
  - id: data_matrix_file
    type: File
    doc: The high-dimensional data matrix
    inputBinding:
      position: 101
      prefix: --data_matrix_file
  - id: normalize
    type:
      - 'null'
      - float
    doc: The data will be divided by this number if provided
    inputBinding:
      position: 101
      prefix: --normalize
  - id: pretrained_model_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'A pretrained scvis model, continue to train this model: the three files of the saved model (.ckpt.index, .ckpt.meta and .ckpt.data-00000-of-00001) made by scvis train, found in the model folder of its output.'
  - id: show_plot
    type:
      - 'null'
      - boolean
    doc: Plot intermediate embedding when this parameter is set
    inputBinding:
      position: 101
      prefix: --show_plot
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print running information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: verbose_interval
    type:
      - 'null'
      - int
    doc: 'Print running information after running # of mini-batches'
    inputBinding:
      position: 101
      prefix: --verbose_interval
  - id: out_dir_path
    type: string?
    doc: Path for output files
    inputBinding:
      position: 102
      prefix: --out_dir
arguments:
  - position: 101
    valueFrom: |
      ${
        var fs = inputs.pretrained_model_files;
        if (!fs) { return []; }
        var idx = fs.filter(function (f) { return f.basename.endsWith('.index'); })[0];
        return ['--pretrained_model_file', idx.basename.replace(/\.index$/, '')];
      }
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path for output files
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.pretrained_model_files ? inputs.pretrained_model_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvis:0.1.0--scvis_0
