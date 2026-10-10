cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaboliteidconverter
label: metaboliteidconverter
doc: "Converts metabolite IDs between different databases.\n\nTool homepage: https://github.com/phnmnl/container-MetaboliteIDConverter"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: headers
    type:
      - 'null'
      - boolean
    doc: use this if the input file has database names on the first line
    inputBinding:
      position: 1
      prefix: -headers
  - id: in_db
    type: string
    doc: "[Required] Input database to convert from."
    inputBinding:
      position: 2
      prefix: -inDB
  - id: in_file
    type:
      - 'null'
      - File
    doc: Input file in tsv file format.
    inputBinding:
      position: 3
      prefix: -inFile
  - id: in_id
    type:
      - 'null'
      - string
    doc: Input ID to convert.
    inputBinding:
      position: 4
      prefix: -inId
  - id: out_db
    type:
      - 'null'
      - type: array
        items: string
    doc: Output databases to convert to.
    inputBinding:
      position: 5
      prefix: -outDB
  - id: out_file
    type: string
    doc: "[Required] Output file name."
    inputBinding:
      position: 6
      prefix: -outFile
outputs:
  - id: output
    type: File
    doc: Output file with the converted IDs
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metaboliteidconverter:phenomenal-v0.5.1_cv1.2.31
