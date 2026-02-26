cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_query
doc: "Query the de Bruijn graph index.\n\nTool homepage: https://github.com/splatlab/mantis"
inputs:
  - id: query
    type: string
    doc: Prefix of input files.
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write the output in JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: kmer
    type:
      - 'null'
      - int
    doc: size of k for kmer.
    inputBinding:
      position: 102
      prefix: -k
  - id: query_prefix
    type: string
    doc: Prefix of input files.
    inputBinding:
      position: 102
      prefix: -p
  - id: use_colorclasses
    type:
      - 'null'
      - boolean
    doc: Use color classes as the color info representation instead of MST
    inputBinding:
      position: 102
      prefix: --use-colorclasses
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Where to write query output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
