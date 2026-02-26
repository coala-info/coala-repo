cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - amrfinderplus
label: tooldistillator_amrfinderplus
doc: "Extract information from output(s) of amrfinderplus (report.tsv)\n\nTool homepage:
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
    doc: amrfinderplus version number for amrfinderplus
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for amrfinderplus file from galaxy for amrfinderplus
    inputBinding:
      position: 102
      prefix: --hid
  - id: nucleotide_sequence_hid
    type:
      - 'null'
      - string
    doc: historic ID for nucleotide sequence fasta file from galaxy for 
      amrfinderplus
    inputBinding:
      position: 102
      prefix: --nucleotide_sequence_hid
  - id: nucleotide_sequence_path
    type:
      - 'null'
      - File
    doc: nucleotide identified sequence fasta file for amrfinderplus
    inputBinding:
      position: 102
      prefix: --nucleotide_sequence_path
  - id: point_mutation_report_hid
    type:
      - 'null'
      - string
    doc: historic ID for point mutation report file from galaxy for 
      amrfinderplus
    inputBinding:
      position: 102
      prefix: --point_mutation_report_hid
  - id: point_mutation_report_path
    type:
      - 'null'
      - File
    doc: point mutation report file for amrfinderplus
    inputBinding:
      position: 102
      prefix: --point_mutation_report_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for amrfinderplus
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
