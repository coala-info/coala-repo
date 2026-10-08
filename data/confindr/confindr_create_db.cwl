cwlVersion: v1.2
class: CommandLineTool
baseCommand: confindr_create_db
label: confindr_create_db
doc: "Create a genus-specific ConFindr core-gene database: downloads the RefSeq assembly
  summary and the complete RefSeq genomes of the genus, BLASTs candidate genes against
  them and writes the genes that hit every genome once to <genus>_db_cgderived.fasta.\n\nTool
  homepage: https://github.com/lowandrew/ConFindr"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: output_folder
    type: string
    doc: Folder to first store temporary files, and eventually store the created database.
    default: confindr_create_db_out
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: input_folder
    type: Directory
    doc: Folder with your input files to try to find core genes. Each gene should be
      in a FASTA file. Expected extension is .fasta
    inputBinding:
      position: 101
      prefix: --input_folder
  - id: genus
    type: string
    doc: Name of genus you're creating a database for.
    inputBinding:
      position: 101
      prefix: --genus
  - id: desired_number_genes
    type:
      - 'null'
      - int
    doc: Minimum number of genes you want to find.
    inputBinding:
      position: 101
      prefix: --desired_number_genes
outputs:
  - id: database
    type:
      - 'null'
      - File
    doc: core-gene database of the genus
    outputBinding:
      glob: $(inputs.genus)_db_cgderived.fasta
  - id: output_directory
    type: Directory
    doc: folder with the downloaded genomes and the gene hit reports
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/confindr:0.8.2--pyhdfd78af_0
