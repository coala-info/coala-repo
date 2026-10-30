cwlVersion: v1.2
class: CommandLineTool
baseCommand: augustus_to_proteindb.rb
label: protk_augustus_to_proteindb.rb
doc: 'Create a protein database from Augustus gene prediction output that is suitable for later processing
  by proteogenomics tools.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: augustus_gff
    type: File
    doc: Augustus gene prediction output (gff3)
    inputBinding:
      position: 1
  - id: info
    type:
      - 'null'
      - boolean
    doc: Include CDS Coordinates
    inputBinding:
      position: 102
      prefix: --info
  - id: output_path
    type: string
    doc: An explicitly named output file. The default is to write to standard output
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
