cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaboliteidconverter
label: metaboliteidconverter
doc: "Converts metabolite IDs between different databases.\n\nTool homepage: https://github.com/phnmnl/container-MetaboliteIDConverter"
inputs:
  - id: headers
    type:
      - 'null'
      - boolean
    doc: use this if the input file has database names on the first line
    inputBinding:
      position: 101
  - id: in_db
    type: string
    doc: Input database to convert from.
    inputBinding:
      position: 101
  - id: in_file
    type:
      - 'null'
      - File
    doc: Input file in tsv file format.
    inputBinding:
      position: 101
  - id: in_id
    type:
      - 'null'
      - string
    doc: Input ID to convert.
    inputBinding:
      position: 101
  - id: out_db
    type:
      - 'null'
      - type: array
        items: string
    doc: Output databases to convert to.
    inputBinding:
      position: 101
  - id: out_file_path
    type: string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type: File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metaboliteidconverter:phenomenal-v0.5.1_cv1.2.31
