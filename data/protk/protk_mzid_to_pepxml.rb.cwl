cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzid_to_pepxml.rb
label: protk_mzid_to_pepxml.rb
doc: 'Convert an mzIdentML file to pep.xml


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: mzid_file
    type: File
    doc: Input mzIdentML file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode
    inputBinding:
      position: 102
      prefix: --debug
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
