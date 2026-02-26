cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge_metaphlan_tables.py
label: metaphlan2_merge_metaphlan_tables.py
doc: "Performs a table join on one or more metaphlan output files.\n\nTool homepage:
  https://bitbucket.org/biobakery/metaphlan2"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more tab-delimited text tables to join
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output file in which joined tables are saved
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan2:2.96.1--py_0
