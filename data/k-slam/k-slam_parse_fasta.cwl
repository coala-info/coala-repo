cwlVersion: v1.2
class: CommandLineTool
baseCommand: SLAM
label: k-slam_parse_fasta
doc: "Build a k-SLAM index from any number of FASTA files (SLAM --parse-fasta). A database built from FASTA files can only be used for alignment (SLAM --just-align).\n\nTool homepage: https://github.com/aindj/k-SLAM"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA files to index
    inputBinding:
      position: 2
      prefix: --parse-fasta
  - id: output_file_path
    type: string
    doc: Name of the index file to write (use "database" to build a database directory)
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
stdout: k-slam_parse_fasta.out
