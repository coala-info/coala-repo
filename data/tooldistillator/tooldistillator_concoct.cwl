cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - concoct
label: tooldistillator_concoct
doc: "Extract information from output(s) of concoct (merge_cluster.tsv)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: Concoct version number for concoct
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: contigs_cut_up_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to contigs cut up fasta file from Galaxy for concoct
    inputBinding:
      position: 102
      prefix: --contigs_cut_up_file_hid
  - id: contigs_cut_up_file_path
    type:
      - 'null'
      - File
    doc: Contigs cut up fasta file from Concoct for concoct
    inputBinding:
      position: 102
      prefix: --contigs_cut_up_file_path
  - id: coordinates_cut_up_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to coordinates contigs cut up bed file from Galaxy for 
      concoct
    inputBinding:
      position: 102
      prefix: --coordinates_cut_up_file_hid
  - id: coordinates_cut_up_file_path
    type:
      - 'null'
      - File
    doc: Coordinates contigs cut up bed file from Concoct for concoct
    inputBinding:
      position: 102
      prefix: --coordinates_cut_up_file_path
  - id: coverage_table_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to coverage table file from Galaxy for concoct
    inputBinding:
      position: 102
      prefix: --coverage_table_file_hid
  - id: coverage_table_file_path
    type:
      - 'null'
      - File
    doc: Coverage table file from Concoct for concoct
    inputBinding:
      position: 102
      prefix: --coverage_table_file_path
  - id: fasta_bin_zip_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to bin fasta format ZIP folder from Galaxy for concoct
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_hid
  - id: fasta_bin_zip_folder_path
    type:
      - 'null'
      - Directory
    doc: Bin fasta format ZIP folder for Concoct for concoct
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to Concoct clusters file from Galaxy for concoct
    inputBinding:
      position: 102
      prefix: --hid
  - id: log_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Concoct log file from Galaxy for concoct
    inputBinding:
      position: 102
      prefix: --log_file_hid
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Log file from Concoct for concoct
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for concoct
    inputBinding:
      position: 102
      prefix: --reference_database_version
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
