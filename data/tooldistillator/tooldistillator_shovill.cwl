cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - shovill
label: tooldistillator_shovill
doc: "Extract information from output(s) of shovill (contig.fasta)\n\nTool homepage:
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
    doc: shovill version number for shovill
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: bam_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to alignment file from Galaxy for shovill
    inputBinding:
      position: 102
      prefix: --bam_file_hid
  - id: bam_file_path
    type:
      - 'null'
      - File
    doc: Binary Alignment file from shovill for shovill
    inputBinding:
      position: 102
      prefix: --bam_file_path
  - id: contig_graph_hid
    type:
      - 'null'
      - string
    doc: Historic ID to assembly graph from Galaxy for shovill
    inputBinding:
      position: 102
      prefix: --contig_graph_hid
  - id: contig_graph_path
    type:
      - 'null'
      - File
    doc: Assembly graph file for shovill
    inputBinding:
      position: 102
      prefix: --contig_graph_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to shovill contigs file from Galaxy for shovill
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for shovill
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
