cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphlan2_merge_metaphlan_tables.py
label: metaphlan2_merge_metaphlan_tables.py
doc: "Merge MetaPhlAn tables (Note: The provided help text contains system error messages
  and no usage information was found).\n\nTool homepage: https://bitbucket.org/biobakery/metaphlan2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan2:2.96.1--py_0
stdout: metaphlan2_merge_metaphlan_tables.py.out
