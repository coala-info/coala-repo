cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-plot-reduced-dim.R
label: scater-scripts_scater-plot-reduced-dim.R
doc: "Plots a reduced dimension result (for example PCA or t-SNE) of a SingleCellExperiment
  object to a PNG file.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: use_dimred
    type:
      - 'null'
      - string
    doc: A string or integer scalar indicating the reduced dimension result in 
      reducedDims(object) to plot.
    inputBinding:
      position: 101
      prefix: --use-dimred
  - id: ncomponents
    type:
      - 'null'
      - string
    doc: A numeric scalar indicating the number of dimensions to plot, starting 
      from the first dimension. Alternatively, a comma-separated list of the 
      dimensions to be plotted.
    inputBinding:
      position: 101
      prefix: --ncomponents
  - id: percent_var
    type:
      - 'null'
      - string
    doc: A comma-separated string giving the proportion of variance in 
      expression explained by each reduced dimension. Only expected to be used 
      in PCA settings.
    inputBinding:
      position: 101
      prefix: --percent-var
  - id: colour_by
    type:
      - 'null'
      - string
    doc: Specification of a column metadata field or a feature to colour by.
    inputBinding:
      position: 101
      prefix: --colour-by
  - id: shape_by
    type:
      - 'null'
      - string
    doc: Specification of a column metadata field or a feature to shape by.
    inputBinding:
      position: 101
      prefix: --shape-by
  - id: size_by
    type:
      - 'null'
      - string
    doc: Specification of a column metadata field or a feature to size by.
    inputBinding:
      position: 101
      prefix: --size-by
  - id: by_exprs_values
    type:
      - 'null'
      - string
    doc: A string or integer scalar specifying which assay to obtain expression 
      values from, for use in point aesthetics.
    inputBinding:
      position: 101
      prefix: --by_exprs-values
  - id: by_show_single
    type:
      - 'null'
      - boolean
    doc: Logical scalar specifying whether single-level factors should be used 
      for point aesthetics.
    inputBinding:
      position: 101
      prefix: --by_show_single
      valueFrom: '$(self ? "TRUE" : "FALSE")'
  - id: png_width
    type:
      - 'null'
      - int
    doc: Width of png (px).
    inputBinding:
      position: 101
      prefix: --png-width
  - id: png_height
    type:
      - 'null'
      - int
    doc: Height of png file (px).
    inputBinding:
      position: 101
      prefix: --png-height
  - id: output_image_file_path
    type: string
    doc: File name in which to save the image
    inputBinding:
      position: 102
      prefix: --output-image-file
outputs:
  - id: output_image_file
    type: File
    doc: PNG image of the reduced dimension plot
    outputBinding:
      glob: $(inputs.output_image_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
