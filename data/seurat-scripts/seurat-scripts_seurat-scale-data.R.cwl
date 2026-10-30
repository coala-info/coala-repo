cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-scale-data.R
label: seurat-scripts_seurat-scale-data.R
doc: 'Scale and centre the data of a Seurat object (Seurat ScaleData).


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
  - id: genes_use
    type:
      - 'null'
      - File
    doc: File with gene names to scale/center (one gene per line). Default is all genes in object@data.
    inputBinding:
      position: 5
      prefix: --genes-use=
      separate: false
  - id: vars_to_regress
    type:
      - 'null'
      - string
    doc: Comma-separated list of variables to regress out (previously latent.vars in RegressOut). For example, nUMI, or percent.mito.
    inputBinding:
      position: 6
      prefix: --vars-to-regress=
      separate: false
  - id: model_use
    type:
      - 'null'
      - string
    doc: Use a linear model or generalized linear model (poisson, negative binomial) for the regression. Options are 'linear' (default), 'poisson', and 'negbinom'.
    inputBinding:
      position: 7
      prefix: --model-use=
      separate: false
  - id: use_umi
    type:
      - 'null'
      - string
    doc: Regress on UMI count data. Default is FALSE for linear modeling, but automatically set to TRUE if model.use is 'negbinom' or 'poisson'.
    inputBinding:
      position: 8
      prefix: --use-umi=
      separate: false
  - id: do_not_scale
    type:
      - 'null'
      - boolean
    doc: Skip the data scale.
    inputBinding:
      position: 9
      prefix: --do-not-scale
  - id: do_not_center
    type:
      - 'null'
      - boolean
    doc: Skip data centering.
    inputBinding:
      position: 10
      prefix: --do-not-center
  - id: scale_max
    type:
      - 'null'
      - float
    doc: Max value to return for scaled data. The default is 10. Setting this can help reduce the effects of genes that are only expressed in a very small number of cells. If regressing out latent variables and using a non-linear model, the default is 50.
    inputBinding:
      position: 11
      prefix: --scale-max=
      separate: false
  - id: block_size
    type:
      - 'null'
      - int
    doc: Default size for number of genes to scale at in a single computation. Increasing block.size may speed up calculations but at an additional memory cost.
    inputBinding:
      position: 12
      prefix: --block-size=
      separate: false
  - id: min_cells_to_block
    type:
      - 'null'
      - int
    doc: If object contains fewer than this number of cells, don't block for scaling calculations.
    inputBinding:
      position: 13
      prefix: --min-cells-to-block=
      separate: false
  - id: check_for_norm
    type:
      - 'null'
      - string
    doc: Check to see if data has been normalized, if not, output a warning (TRUE by default).
    inputBinding:
      position: 14
      prefix: --check-for-norm=
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
