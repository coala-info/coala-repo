cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - maxbin2
label: tooldistillator_maxbin2
doc: "Extract information from output(s) of maxbin2 (bin_summary.tsv)\n\nTool homepage:
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
    doc: Maxbin2 version number for maxbin2
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: bin_predicted_markers_zip_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to bin predicted markers ZIP folder from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --bin_predicted_markers_zip_folder_hid
  - id: bin_predicted_markers_zip_folder_path
    type:
      - 'null'
      - File
    doc: Bin predicted markers ZIP folder for Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --bin_predicted_markers_zip_folder_path
  - id: fasta_bin_zip_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to bin fasta format ZIP folder from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_hid
  - id: fasta_bin_zip_folder_path
    type:
      - 'null'
      - File
    doc: Bin fasta format ZIP folder for Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to Maxbin2 contigs file from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --hid
  - id: log_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Maxbin2 log file from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --log_file_hid
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Log file from Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: marker_gene_presence_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to marker gene presence file from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --marker_gene_presence_file_hid
  - id: marker_gene_presence_file_path
    type:
      - 'null'
      - File
    doc: Marker gene presence file from Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --marker_gene_presence_file_path
  - id: marker_gene_presence_plot_hid
    type:
      - 'null'
      - string
    doc: Historic ID to marker gene presence plot from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --marker_gene_presence_plot_hid
  - id: marker_gene_presence_plot_path
    type:
      - 'null'
      - File
    doc: Marker gene presence plot from Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --marker_gene_presence_plot_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for maxbin2
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: too_short_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to too short sequences file from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --too_short_sequences_file_hid
  - id: too_short_sequences_file_path
    type:
      - 'null'
      - File
    doc: Too short sequences file from Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --too_short_sequences_file_path
  - id: unclassified_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to unclassified sequences file from Galaxy for maxbin2
    inputBinding:
      position: 102
      prefix: --unclassified_sequences_file_hid
  - id: unclassified_sequences_file_path
    type:
      - 'null'
      - File
    doc: Unclassified sequences file from Maxbin2 for maxbin2
    inputBinding:
      position: 102
      prefix: --unclassified_sequences_file_path
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
