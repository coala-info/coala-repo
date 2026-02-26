cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - metabat2
label: tooldistillator_metabat2
doc: "Extract information from output(s) of metabat2 (depth.txt)\n\nTool homepage:
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
    doc: Metabat2 version number for metabat2
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: fasta_bin_zip_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to bin fasta format ZIP folder from Galaxy for metabat2
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_hid
  - id: fasta_bin_zip_folder_path
    type:
      - 'null'
      - Directory
    doc: Bin fasta format ZIP folder for Metabat2 for metabat2
    inputBinding:
      position: 102
      prefix: --fasta_bin_zip_folder_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to Metabat2 clusters file from Galaxy for metabat2
    inputBinding:
      position: 102
      prefix: --hid
  - id: low_depth_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to low depth sequences file from Galaxy for metabat2
    inputBinding:
      position: 102
      prefix: --low_depth_sequences_file_hid
  - id: low_depth_sequences_file_path
    type:
      - 'null'
      - File
    doc: Low depth file from Metabat2 for metabat2
    inputBinding:
      position: 102
      prefix: --low_depth_sequences_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for metabat2
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: too_short_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to too short sequences file from Galaxy for metabat2
    inputBinding:
      position: 102
      prefix: --too_short_sequences_file_hid
  - id: too_short_sequences_file_path
    type:
      - 'null'
      - File
    doc: Too short sequences file from Metabat2 for metabat2
    inputBinding:
      position: 102
      prefix: --too_short_sequences_file_path
  - id: unbinned_sequences_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to unbinned sequences file from Galaxy for metabat2
    inputBinding:
      position: 102
      prefix: --unbinned_sequences_file_hid
  - id: unbinned_sequences_file_path
    type:
      - 'null'
      - File
    doc: Unbinned sequences file from Metabat2 for metabat2
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
