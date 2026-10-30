cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-normalise-data.R
label: seurat-scripts_seurat-normalise-data.R
doc: 'Normalise the data of a Seurat object (Seurat NormalizeData).


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
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 3
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 4
      prefix: --output-format=
      separate: false
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Method for normalization. Default is log-normalization (LogNormalize). Can be 'CLR' or 'RC' additionally.
    inputBinding:
      position: 5
      prefix: --normalization-method=
      separate: false
  - id: scale_factor
    type:
      - 'null'
      - int
    doc: Sets the scale factor for cell-level normalization.
    inputBinding:
      position: 6
      prefix: --scale-factor=
      separate: false
  - id: margin
    type:
      - 'null'
      - int
    doc: If performing CLR normalization, normalize across features (1) or cells (2).
    inputBinding:
      position: 7
      prefix: --margin=
      separate: false
  - id: block_size
    type:
      - 'null'
      - int
    doc: How many cells should be run in each chunk, will try to split evenly across threads
    inputBinding:
      position: 8
      prefix: --block-size=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
