cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - prodigal
label: tooldistillator_prodigal
doc: "Extract information from output(s) of prodigal (gene_coordinates.tsv)\n\nTool
  homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: Prodigal version number for prodigal
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: gbk_genes_coordinate_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to GBK genes coordinate file from Galaxy for prodigal
    inputBinding:
      position: 102
      prefix: --gbk_genes_coordinate_file_hid
  - id: gbk_genes_coordinate_file_path
    type:
      - 'null'
      - File
    doc: GBK genes coordinate file for prodigal for prodigal
    inputBinding:
      position: 102
      prefix: --gbk_genes_coordinate_file_path
  - id: gff_genes_coordinate_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to GFF3 genes coordinate file from Galaxy for prodigal
    inputBinding:
      position: 102
      prefix: --gff_genes_coordinate_file_hid
  - id: gff_genes_coordinate_file_path
    type:
      - 'null'
      - File
    doc: GFF3 genes coordinate file for prodigal for prodigal
    inputBinding:
      position: 102
      prefix: --gff_genes_coordinate_file_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for Prodigal file from galaxy for prodigal
    inputBinding:
      position: 102
      prefix: --hid
  - id: potential_gene_start_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to potential genes start file from Galaxy for prodigal
    inputBinding:
      position: 102
      prefix: --potential_gene_start_file_hid
  - id: potential_gene_start_file_path
    type:
      - 'null'
      - File
    doc: Potential genes start file for prodigal for prodigal
    inputBinding:
      position: 102
      prefix: --potential_gene_start_file_path
  - id: protein_translation_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to proteins fasta file from Galaxy for prodigal
    inputBinding:
      position: 102
      prefix: --protein_translation_file_hid
  - id: protein_translation_file_path
    type:
      - 'null'
      - File
    doc: Proteins from all the sequences fasta file for prodigal for prodigal
    inputBinding:
      position: 102
      prefix: --protein_translation_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for prodigal
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: sco_genes_coordinate_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to SCO genes coordinate file from Galaxy for prodigal
    inputBinding:
      position: 102
      prefix: --sco_genes_coordinate_file_hid
  - id: sco_genes_coordinate_file_path
    type:
      - 'null'
      - File
    doc: SCO genes coordinate file for prodigal for prodigal
    inputBinding:
      position: 102
      prefix: --sco_genes_coordinate_file_path
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
