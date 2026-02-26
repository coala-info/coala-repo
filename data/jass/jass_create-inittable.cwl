cwlVersion: v1.2
class: CommandLineTool
baseCommand: jass create-inittable
label: jass_create-inittable
doc: "Creates an initial table for JASS based on input data and configuration.\n\n\
  Tool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: description_file_path
    type: File
    doc: path to the GWAS studies metadata file
    inputBinding:
      position: 101
      prefix: --description-file-path
  - id: init_covariance_path
    type:
      - 'null'
      - File
    doc: path to the covariance file to import
    inputBinding:
      position: 101
      prefix: --init-covariance-path
  - id: init_genetic_covariance_path
    type:
      - 'null'
      - File
    doc: "path to the genetic covariance file to import. Used\nonly for display on
      Jass web application"
    inputBinding:
      position: 101
      prefix: --init-genetic-covariance-path
  - id: init_table_path
    type:
      - 'null'
      - File
    doc: "path to the initial data file to produce, default is\nthe configured path
      (JASS_DATA_DIR/initTable.hdf5)"
    default: JASS_DATA_DIR/initTable.hdf5
    inputBinding:
      position: 101
      prefix: --init-table-path
  - id: input_data_path
    type: File
    doc: "path to the GWAS data file (ImpG format) to import.\nthe path must be specify
      between quotes"
    inputBinding:
      position: 101
      prefix: --input-data-path
  - id: regions_map_path
    type: File
    doc: path to the genome regions map (BED format) to import
    inputBinding:
      position: 101
      prefix: --regions-map-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_create-inittable.out
