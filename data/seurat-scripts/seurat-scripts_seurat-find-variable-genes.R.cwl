cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-variable-genes.R
label: seurat-scripts_seurat-find-variable-genes.R
doc: 'Find highly variable genes in a Seurat object (Seurat FindVariableFeatures).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R object of type 'Seurat'.'
    inputBinding:
      position: 2
      prefix: --output-object-file=
      separate: false
  - id: output_text_file
    type: string
    doc: File name in which to store variable genes in plain text.
    inputBinding:
      position: 3
      prefix: --output-text-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 4
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 5
      prefix: --output-format=
      separate: false
  - id: selection_method
    type:
      - 'null'
      - string
    doc: 'How to choose top variable features. Choose one of: ''vst'', ''mvp'', disp.'
    inputBinding:
      position: 6
      prefix: --selection-method=
      separate: false
  - id: mean_function
    type:
      - 'null'
      - string
    doc: Function to compute x-axis value (average expression). Default is to take the mean of the detected (i.e. non-zero) values.
    inputBinding:
      position: 7
      prefix: --mean-function=
      separate: false
  - id: dispersion_function
    type:
      - 'null'
      - string
    doc: Function to compute y-axis value (dispersion). Default is to take the standard deviation of all values.
    inputBinding:
      position: 8
      prefix: --dispersion-function=
      separate: false
  - id: x_low_cutoff
    type:
      - 'null'
      - float
    doc: Bottom cutoff on x-axis (mean) for identifying variable genes.
    inputBinding:
      position: 9
      prefix: --x-low-cutoff=
      separate: false
  - id: x_high_cutoff
    type:
      - 'null'
      - float
    doc: Top cutoff on x-axis (mean) for identifying variable genes.
    inputBinding:
      position: 10
      prefix: --x-high-cutoff=
      separate: false
  - id: nfeatures
    type:
      - 'null'
      - int
    doc: Number of features to return.
    inputBinding:
      position: 11
      prefix: --nfeatures=
      separate: false
  - id: y_low_cutoff
    type:
      - 'null'
      - float
    doc: Bottom cutoff on y-axis (dispersion) for identifying variable genes.
    inputBinding:
      position: 12
      prefix: --y-low-cutoff=
      separate: false
  - id: y_high_cutoff
    type:
      - 'null'
      - float
    doc: Top cutoff on y-axis (dispersion) for identifying variable genes.
    inputBinding:
      position: 13
      prefix: --y-high-cutoff=
      separate: false
  - id: loess_span
    type:
      - 'null'
      - float
    doc: '(vst method) Loess span parameter used when fitting the variance-mean relationship. Default: 0.3'
    inputBinding:
      position: 14
      prefix: --loess-span=
      separate: false
  - id: clip_max
    type:
      - 'null'
      - string
    doc: (vst method) After standardization values larger than clip.max will be set to clip.max; default is 'auto' which sets this value to the square root of the number of cells.
    inputBinding:
      position: 15
      prefix: --clip-max=
      separate: false
  - id: num_bin
    type:
      - 'null'
      - int
    doc: Total number of bins to use in the scaled analysis (default is 20).
    inputBinding:
      position: 16
      prefix: --num-bin=
      separate: false
  - id: binning_method
    type:
      - 'null'
      - string
    doc: 'Specifies how the bins should be computed. Available methods are either equal_width: each bin is of equal width along the x-axis [default]; or equal_frequency: each bin contains an equal number of features (can increase statistical power to detect overdispersed features at high expression values, at the cost of reduced resolution along the x-axis)'
    inputBinding:
      position: 17
      prefix: --binning-method=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_text_file
    type: File
    doc: File name in which to store variable genes in plain text.
    outputBinding:
      glob: $(inputs.output_text_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
