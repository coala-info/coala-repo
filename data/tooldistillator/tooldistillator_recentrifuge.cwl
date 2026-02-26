cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - recentrifuge
label: tooldistillator_recentrifuge
doc: "Extract information from output(s) of recentrifuge (data.tsv)\n\nTool homepage:
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
    doc: recentrifuge version for recentrifuge
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID to recentrifuge data file provided by Galaxy for 
      recentrifuge
    inputBinding:
      position: 102
      prefix: --hid
  - id: rcf_html_hid
    type:
      - 'null'
      - string
    doc: recentrifuge html report file for recentrifuge
    inputBinding:
      position: 102
      prefix: --rcf_html_hid
  - id: rcf_html_path
    type:
      - 'null'
      - File
    doc: recentrifuge html report file for recentrifuge
    inputBinding:
      position: 102
      prefix: --rcf_html_path
  - id: rcf_stat_hid
    type:
      - 'null'
      - string
    doc: historic ID provided by Galaxy for recentrifuge
    inputBinding:
      position: 102
      prefix: --rcf_stat_hid
  - id: rcf_stat_path
    type:
      - 'null'
      - File
    doc: recentrifuge statistic file for recentrifuge
    inputBinding:
      position: 102
      prefix: --rcf_stat_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: ncbi taxonomy DB version for recentrifuge
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
