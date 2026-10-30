cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem_to_pepxml.rb
label: protk_tandem_to_pepxml.rb
doc: 'Convert tandem files to pep.xml files.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: tandem_files
    type:
      type: array
      items: File
    doc: X!Tandem result files
    inputBinding:
      position: 1
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: A string to prepend to the name of output files
    inputBinding:
      position: 102
      prefix: --output-prefix
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
