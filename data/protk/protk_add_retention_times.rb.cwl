cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_retention_times.rb
label: protk_add_retention_times.rb
doc: 'Look up retention times in a raw file and add them to a pepxml file.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: pepxml_file
    type: File
    doc: Input pepXML file
    inputBinding:
      position: 1
  - id: mgf_file
    type: File
    doc: Input mgf file with retention times
    inputBinding:
      position: 2
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
