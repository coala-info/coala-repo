cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - plasmidfinder
label: tooldistillator_plasmidfinder
doc: "Extract information from output(s) of plasmidfinder (plasmidfinder.tsv)\n\n\
  Tool homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: plasmidfinder version for plasmidfinder
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: genome_hit_hid
    type:
      - 'null'
      - string
    doc: Historic ID for genome hit file from galaxy for plasmidfinder
    inputBinding:
      position: 102
      prefix: --genome_hit_hid
  - id: genome_hit_path
    type:
      - 'null'
      - File
    doc: fasta file with hits in genome, doesn't work for multiple input for 
      plasmidfinder
    inputBinding:
      position: 102
      prefix: --genome_hit_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID for plasmidfinder file from galaxy for plasmidfinder
    inputBinding:
      position: 102
      prefix: --hid
  - id: plasmid_hit_hid
    type:
      - 'null'
      - string
    doc: Historic ID for plasmid sequence hit file from galaxy for plasmidfinder
    inputBinding:
      position: 102
      prefix: --plasmid_hit_hid
  - id: plasmid_hit_path
    type:
      - 'null'
      - File
    doc: fasta file with plasmid sequences, doesn't work for multiple input for 
      plasmidfinder
    inputBinding:
      position: 102
      prefix: --plasmid_hit_path
  - id: plasmid_result_tabular_hid
    type:
      - 'null'
      - string
    doc: plasmidfinder results hid in Galaxy for plasmidfinder
    inputBinding:
      position: 102
      prefix: --plasmid_result_tabular_hid
  - id: plasmid_result_tabular_path
    type:
      - 'null'
      - File
    doc: plasmidfinder results in tabular format for plasmidfinder
    inputBinding:
      position: 102
      prefix: --plasmid_result_tabular_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: plasmidfinder DB version for plasmidfinder
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
