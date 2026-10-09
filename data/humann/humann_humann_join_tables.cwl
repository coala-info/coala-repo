cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_join_tables
label: humann_humann_join_tables
doc: "Join gene, pathway, or taxonomy tables\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs:
  - id: input
    type: Directory
    doc: "the directory of tables"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "the table to write"
    inputBinding:
      position: 102
      prefix: "--output"
  - id: file_name
    type:
      - 'null'
      - string
    doc: "only join tables with this string included in the file name"
    inputBinding:
      position: 103
      prefix: "--file_name"
  - id: search_subdirectories
    type:
      - 'null'
      - boolean
    doc: "search sub-directories of input folder for files"
    inputBinding:
      position: 104
      prefix: "--search-subdirectories"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "additional output is printed"
    inputBinding:
      position: 105
      prefix: "--verbose"
outputs:
  - id: output
    type: File
    doc: "the joined table"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
