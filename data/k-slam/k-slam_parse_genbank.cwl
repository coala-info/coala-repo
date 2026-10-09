cwlVersion: v1.2
class: CommandLineTool
baseCommand: SLAM
label: k-slam_parse_genbank
doc: "Build a k-SLAM index from any number of GenBank flat files (SLAM --parse-genbank).\n\nTool homepage: https://github.com/aindj/k-SLAM"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: taxDB
        entry: $(inputs.taxonomy_db)
inputs:
  - id: taxonomy_db
    type: File
    doc: k-SLAM taxonomy database made by SLAM --parse-taxonomy (staged as taxDB in the working directory, where SLAM looks for it)
  - id: genbank_files
    type:
      type: array
      items: File
    doc: GenBank flat files to index
    inputBinding:
      position: 2
      prefix: --parse-genbank
  - id: output_file_path
    type: string
    doc: Name of the index file to write (use "database" inside the database directory)
    inputBinding:
      position: 1
      prefix: --output-file
outputs:
  - id: index_file
    type: File
    doc: k-SLAM index written to the output file name
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log of the index build
    outputBinding:
      glob: log.txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k-slam:1.0--1
stdout: k-slam_parse_genbank.out
