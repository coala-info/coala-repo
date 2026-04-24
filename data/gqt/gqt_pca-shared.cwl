cwlVersion: v1.2
class: CommandLineTool
baseCommand: gqt pca-shared
label: gqt_pca-shared
doc: "Performs Principal Component Analysis (PCA) on shared genotypes between populations.\n\
  \nTool homepage: https://github.com/ryanlayer/gqt"
inputs:
  - id: gqt_file
    type: File
    doc: Input GQT file
    inputBinding:
      position: 101
      prefix: -i
  - id: label_db_field_name
    type: string
    doc: Label database field name (required for pca-shared)
    inputBinding:
      position: 101
      prefix: -f
  - id: label_output_file
    type: File
    doc: Label output file (required for pca-shared)
    inputBinding:
      position: 101
      prefix: -l
  - id: ped_database_file
    type: File
    doc: PED database file
    inputBinding:
      position: 101
      prefix: -d
  - id: population_queries
    type:
      type: array
      items: string
    doc: Population query defining a subpopulation. Multiple queries can be 
      provided.
    inputBinding:
      position: 101
      prefix: -p
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: Temporary directory name for remote files
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_pca-shared.out
