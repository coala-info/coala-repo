cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downsample_cells.R
label: cell-types-analysis_downsample_cells.R
doc: "Weighted down-sampling of cells to avoid memory overflow when training classifiers;
  the most prevalent cell types are reduced first and cell types with fewer cells than
  a threshold are removed. Exits with status 2 (no outputs) when no down-sampling is
  required and no minor cell types are found.\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: expression_data
    type: Directory
    doc: 10xGenomics-type directory holding expression matrix, genes, and 
      barcodes
    inputBinding:
      position: 101
      prefix: --expression-data
  - id: metadata
    type: File
    doc: Metadata file mapping cells to cell types
    inputBinding:
      position: 101
      prefix: --metadata
  - id: exclusions
    type:
      - 'null'
      - File
    doc: Path to the yaml file with excluded terms for initial matrix filtering
    inputBinding:
      position: 101
      prefix: --exclusions
  - id: cell_id_field
    type:
      - 'null'
      - string
    doc: Name of cell id column in metada file (default id)
    inputBinding:
      position: 101
      prefix: --cell-id-field
  - id: cell_type_field
    type:
      - 'null'
      - string
    doc: Name of cell type column in metada file (default inferred.cell.type)
    inputBinding:
      position: 101
      prefix: --cell-type-field
  - id: array_size_limit
    type:
      - 'null'
      - long
    doc: Maximum length of R array (default 2000000000)
    inputBinding:
      position: 101
      prefix: --array-size-limit
  - id: cell_count_threshold
    type:
      - 'null'
      - int
    doc: Threshold number of cells to keep a cell type in the matrix (default 5)
    inputBinding:
      position: 101
      prefix: --cell-count-threshold
  - id: output_dir_path
    type: string
    doc: Output directory for downsampled expression data
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: metadata_upd_path
    type: string
    doc: Updated metadata file output path
    inputBinding:
      position: 102
      prefix: --metadata-upd
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the downsampled 10x expression data (matrix.mtx,
      genes.tsv, barcodes.tsv)
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: metadata_upd
    type: File
    doc: Updated metadata file for the kept cells
    outputBinding:
      glob: $(inputs.metadata_upd_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
