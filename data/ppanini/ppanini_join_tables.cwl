cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_join_tables
label: ppanini_join_tables
doc: "Join gene, pathway, or taxonomy tables.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: input
    type: Directory
    doc: "The directory of tables"
    inputBinding:
      position: 101
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Additional output is printed"
    inputBinding:
      position: 101
      prefix: -v
  - id: file_name
    type:
      - 'null'
      - string
    doc: "Only join tables with this string included in the file name"
    inputBinding:
      position: 101
      prefix: --file_name
  - id: search_subdirectories
    type:
      - 'null'
      - boolean
    doc: "Search sub-directories of input folder for files"
    inputBinding:
      position: 101
      prefix: -s
  - id: mapping_uniref
    type:
      - 'null'
      - File
    doc: "Mapping file: gene to uniref90 file"
    inputBinding:
      position: 101
      prefix: --mapping-uniref
  - id: mapping_cluster
    type:
      - 'null'
      - File
    doc: "Mapping file: cluster to genes file"
    inputBinding:
      position: 101
      prefix: --mapping-cluster
  - id: resume
    type:
      - 'null'
      - boolean
    doc: "Bypass commands if the output files exist"
    inputBinding:
      position: 101
      prefix: -r
  - id: scale
    type:
      - 'null'
      - string
    doc: "Scale the abundance table: rpk or count"
    inputBinding:
      position: 101
      prefix: --scale
  - id: output_path
    type: string
    doc: "The table to write"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: File
    doc: Joined table
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_join_tables.out
