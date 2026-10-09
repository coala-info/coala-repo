cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - add-gene-annotation
label: jass_add-gene-annotation
doc: "Add gene and exon annotation (from a RefSeq GFF file) to an initial table. The
  table is updated in place, so a writable copy is staged and returned.\n\nTool homepage:
  http://statistical-genetics.pages.pasteur.fr/jass/"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: JASS_PROJECTS_DIR
        envValue: $(runtime.outdir)/jass_projects
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.init_table_path)
        writable: true
inputs:
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
      valueFrom: $(self.basename)
  - id: gene_csv_path
    type: string
    doc: path of the file df_gene.csv to write (JASS fails if it is not given)
    inputBinding:
      position: 101
      prefix: --gene-csv-path
  - id: exon_csv_path
    type: string
    doc: path of the file df_exon.csv to write (JASS fails if it is not given)
    inputBinding:
      position: 101
      prefix: --exon-csv-path
outputs:
  - id: init_table
    type: File
    doc: The initial table updated with the Gene and Exon tables
    outputBinding:
      glob: $(inputs.init_table_path.basename)
  - id: gene_csv
    type: File
    doc: The gene table in csv format
    outputBinding:
      glob: $(inputs.gene_csv_path)
  - id: exon_csv
    type: File
    doc: The exon table in csv format
    outputBinding:
      glob: $(inputs.exon_csv_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
