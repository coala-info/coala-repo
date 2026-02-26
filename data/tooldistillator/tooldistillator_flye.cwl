cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - flye
label: tooldistillator_flye
doc: "Extract information from output(s) of flye (contig.fasta)\n\nTool homepage:
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
    doc: flye version number for flye
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: contig_graph_hid
    type:
      - 'null'
      - string
    doc: Historic ID to assembly graph from Galaxy for flye
    inputBinding:
      position: 102
      prefix: --contig_graph_hid
  - id: contig_graph_path
    type:
      - 'null'
      - File
    doc: Assembly graph file for flye
    inputBinding:
      position: 102
      prefix: --contig_graph_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to flye contigs file from Galaxy for flye
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for flye
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: tsv_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to assembly info file from Galaxy for flye
    inputBinding:
      position: 102
      prefix: --tsv_file_hid
  - id: tsv_file_path
    type:
      - 'null'
      - File
    doc: Assembly info file from flye for flye
    inputBinding:
      position: 102
      prefix: --tsv_file_path
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
