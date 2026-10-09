cwlVersion: v1.2
class: CommandLineTool
baseCommand: SLAM
label: k-slam_parse_taxonomy
doc: "Parse the NCBI taxonomy names.dmp and nodes.dmp files to produce a k-SLAM taxonomy database (SLAM --parse-taxonomy).\n\nTool homepage: https://github.com/aindj/k-SLAM"
inputs:
  - id: names_dmp
    type: File
    doc: NCBI taxonomy names.dmp file
    inputBinding:
      position: 2
      prefix: --parse-taxonomy
  - id: nodes_dmp
    type: File
    doc: NCBI taxonomy nodes.dmp file
    inputBinding:
      position: 3
  - id: output_file_path
    type: string
    doc: Name of the taxonomy database to write (use "taxDB" inside the database directory)
    inputBinding:
      position: 1
      prefix: --output-file
outputs:
  - id: taxonomy_db
    type: File
    doc: k-SLAM taxonomy database
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log of the build
    outputBinding:
      glob: log.txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k-slam:1.0--1
stdout: k-slam_parse_taxonomy.out
