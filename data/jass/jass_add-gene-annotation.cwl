cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - add-gene-annotation
label: jass_add-gene-annotation
doc: "Add gene annotation to an initial table.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: exon_csv_path
    type:
      - 'null'
      - File
    doc: path to the file df_exon.csv
    inputBinding:
      position: 101
      prefix: --exon-csv-path
  - id: gene_csv_path
    type:
      - 'null'
      - File
    doc: path to the file df_gene.csv
    inputBinding:
      position: 101
      prefix: --gene-csv-path
  - id: gene_data_path
    type: File
    doc: path to the GFF file containing gene and exon data
    inputBinding:
      position: 101
      prefix: --gene-data-path
  - id: init_table_path
    type: File
    doc: path to the initial table file to update
    inputBinding:
      position: 101
      prefix: --init-table-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_add-gene-annotation.out
