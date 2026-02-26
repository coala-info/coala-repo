cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - gst
label: gqt_gst
doc: "Calculates GST and FST statistics for subpopulations. NOTE: gst and fst assume
  that variants are biallelic. If your data contains multiallelic sites, we recommend
  decomposing your VCF (see A. Tan, Bioinformatics 2015) prior to indexing.\n\nTool
  homepage: https://github.com/ryanlayer/gqt"
inputs:
  - id: gqt_file
    type: File
    doc: gqt file
    inputBinding:
      position: 101
      prefix: -i
  - id: label_db_field_name
    type:
      - 'null'
      - string
    doc: label db field name (requried for pca-shared)
    inputBinding:
      position: 101
      prefix: -f
  - id: label_output_file
    type:
      - 'null'
      - File
    doc: label output file (requried for pca-shared)
    inputBinding:
      position: 101
      prefix: -l
  - id: ped_database_file
    type: File
    doc: ped database file
    inputBinding:
      position: 101
      prefix: -d
  - id: population_query
    type:
      - 'null'
      - type: array
        items: string
    doc: "Each population query defines one subpopulation. For example, to find compare
      the GBR and YRI subpopulations: -p \"Population = 'GBR'\" -p \"Population =
      'YRI'\". Population queries are based on the PED file that is associated with
      the genotypes, and any column in that PED file can be part of the query. For
      example, a PED file that includes the \"Paternal_ID\" and \"Gender\" fields
      (where male = 1 and female = 2) could be queried by: -p \"Paternal_ID = 'NA12878'
      AND Gender = 2\""
    inputBinding:
      position: 101
      prefix: -p
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: tmp direcory name for remote files
    default: ./
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
stdout: gqt_gst.out
