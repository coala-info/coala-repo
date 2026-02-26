cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - dastool
label: tooldistillator_dastool
doc: "Extract information from output(s) of dastool (summary.tsv)\n\nTool homepage:
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
    doc: DasTool version number for dastool
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: contig_to_bin_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to contig to bin file from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --contig_to_bin_file_hid
  - id: contig_to_bin_file_path
    type:
      - 'null'
      - File
    doc: Contig to bin file from DasTool for dastool
    inputBinding:
      position: 102
      prefix: --contig_to_bin_file_path
  - id: fasta_bin_zip_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to bin fasta format ZIP folder from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_hid
  - id: fasta_bin_zip_folder_path
    type:
      - 'null'
      - Directory
    doc: Bin fasta format ZIP folder for DasTool for dastool
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to DasTool clusters file from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --hid
  - id: log_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to DasTool log file from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --log_file_hid
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Log file from DasTool for dastool
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: protein_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to protein sequences file from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --protein_sequences_file_hid
  - id: protein_sequences_file_path
    type:
      - 'null'
      - File
    doc: Protein sequences file from DasTool for dastool
    inputBinding:
      position: 102
      prefix: --protein_sequences_file_path
  - id: quality_and_completness_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to quality and completness file from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --quality_and_completness_file_hid
  - id: quality_and_completness_file_path
    type:
      - 'null'
      - File
    doc: Quality and completness file from DasTool for dastool
    inputBinding:
      position: 102
      prefix: --quality_and_completness_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for dastool
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: unbinned_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to unbinned sequences file from Galaxy for dastool
    inputBinding:
      position: 102
      prefix: --unbinned_sequences_file_hid
  - id: unbinned_sequences_file_path
    type:
      - 'null'
      - File
    doc: Unbinned sequences file from DasTool for dastool
    inputBinding:
      position: 102
      prefix: --unbinned_sequences_file_path
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
