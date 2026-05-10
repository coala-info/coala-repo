cwlVersion: v1.2
class: CommandLineTool
baseCommand: matam_compare_samples.py
label: matam_matam_compare_samples.py
doc: "This script let you compare two or more samples coming from MATAM -- v1.5.1
  or superior\n\nTool homepage: https://github.com/bonsai-team/matam"
inputs:
  - id: samples_file
    type: File
    doc: A tabulated file with one sample by row. The first column contains the 
      sample id (must be unique) The second column contains the fasta path. The 
      abundances must be present into this file. The third, the rdp path. Paths 
      can be absolute or relative to the current working directory.
    inputBinding:
      position: 101
      prefix: --samples_file
  - id: ouput_comparaison_table_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ouput_comparaison_table_path`
    inputBinding:
      position: 102
      prefix: --ouput-comparaison-table
  - id: ouput_contingency_table_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ouput_contingency_table_path`
    inputBinding:
      position: 103
      prefix: --ouput-contingency-table
outputs:
  - id: ouput_contingency_table
    type: File
    doc: Output a table with the abundance for each sequence
    outputBinding:
      glob: $(inputs.ouput_contingency_table_path)
  - id: ouput_comparaison_table
    type: File
    doc: Output a comparaison table (taxonomy vs samples)
    outputBinding:
      glob: $(inputs.ouput_comparaison_table_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
