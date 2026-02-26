cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - megahit
label: tooldistillator_megahit
doc: "Extract information from output(s) of megahit (contig.fasta)\n\nTool homepage:
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
    doc: megahit version number for megahit
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to megahit contigs file from Galaxy for megahit
    inputBinding:
      position: 102
      prefix: --hid
  - id: intermediate_contig_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to intermediate contig folder from Galaxy for megahit
    inputBinding:
      position: 102
      prefix: --intermediate_contig_folder_hid
  - id: intermediate_contig_folder_path
    type:
      - 'null'
      - Directory
    doc: Intermediate contig folder for Megahit assembly for megahit
    inputBinding:
      position: 102
      prefix: --intermediate_contig_folder_path
  - id: log_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to megahit log file from Galaxy for megahit
    inputBinding:
      position: 102
      prefix: --log_file_hid
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Log file from megahit for megahit
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for megahit
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
