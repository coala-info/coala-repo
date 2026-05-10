cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-filter.R
label: scater-scripts_scater-filter.R
doc: "Filters cells and features from a SingleCellExperiment object based on specified
  criteria.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: cells_discard
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of cell names to discard as a subset. 
      Alternatively, text file with one cell per line providing cell names to 
      discard as a subset.
    inputBinding:
      position: 101
      prefix: --cells-discard
  - id: cells_use
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of cell names to use as a subset. Alternatively, 
      text file with one cell per line providing cell names to use as a subset.
    inputBinding:
      position: 101
      prefix: --cells-use
  - id: features_use
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of feature names to use as a subset. 
      Alternatively, text file with one feature per line providing feature names
      to use as a subset.
    inputBinding:
      position: 101
      prefix: --features-use
  - id: high_cell_thresholds
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated high cutoffs for the parameters.
    inputBinding:
      position: 101
      prefix: --high-cell-thresholds
  - id: high_feature_thresholds
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated high cutoffs for the parameters.
    inputBinding:
      position: 101
      prefix: --high-feature-thresholds
  - id: input_object_file
    type: File
    doc: A serialized SingleCellExperiment object file in RDS format.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: low_cell_thresholds
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated low cutoffs for the parameters.
    inputBinding:
      position: 101
      prefix: --low-cell-thresholds
  - id: low_feature_thresholds
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated low cutoffs for the parameters.
    inputBinding:
      position: 101
      prefix: --low-feature-thresholds
  - id: subset_cell_variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated parameters to subset on. Any variable available in the 
      colData of the supplied object.
    inputBinding:
      position: 101
      prefix: --subset-cell-variables
  - id: subset_feature_variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated parameters to subset on. Any variable available in the 
      colData of the supplied object.
    inputBinding:
      position: 101
      prefix: --subset-feature-variables
  - id: output_cellselect_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_cellselect_file_path`
    inputBinding:
      position: 102
      prefix: --output-cellselect-file
  - id: output_featureselect_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_featureselect_file_path`
    inputBinding:
      position: 103
      prefix: --output-featureselect-file
  - id: output_object_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_object_file_path`
    inputBinding:
      position: 104
      prefix: --output-object-file
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized R object of type 'Seurat'.
    outputBinding:
      glob: $(inputs.output_object_file_path)
  - id: output_cellselect_file
    type:
      - 'null'
      - File
    doc: File name in which to store a matrix showing results of applying 
      individual cell selection criteria.
    outputBinding:
      glob: $(inputs.output_cellselect_file_path)
  - id: output_featureselect_file
    type:
      - 'null'
      - File
    doc: File name in which to store a matrix showing results of applying 
      individual feature selection criteria.
    outputBinding:
      glob: $(inputs.output_featureselect_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
