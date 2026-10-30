cwlVersion: v1.2
class: CommandLineTool
baseCommand: uniprot_mapper.rb
label: protk_uniprot_mapper.rb
doc: 'Given a set of IDs convert them to a different type of ID


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: input_file
    type: File
    doc: Input file of IDs (tab delimited)
    inputBinding:
      position: 1
  - id: from_id_type
    type: string
    doc: Type of the input IDs
    inputBinding:
      position: 2
  - id: id_column
    type:
      - 'null'
      - int
    doc: Specify a column for ids (default is column 1)
    inputBinding:
      position: 102
      prefix: --id-column
  - id: to_id
    type: string
    doc: Specify an ID to output. Exactly one is required
    inputBinding:
      position: 102
      prefix: --to-id
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
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
