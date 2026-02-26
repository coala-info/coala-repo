cwlVersion: v1.2
class: CommandLineTool
baseCommand: Pacini-typing query
label: pacini_typing_query
doc: "Query the Pacini database with sequencing reads.\n\nTool homepage: https://github.com/RIVM-bioinformatics/Pacini-typing"
inputs:
  - id: db_name
    type: string
    doc: Specify the name of the database
    inputBinding:
      position: 101
      prefix: --database_name
  - id: db_path
    type: Directory
    doc: Specify the location of the database, ending with /
    inputBinding:
      position: 101
      prefix: --database_path
  - id: paired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Paired-end reads to be used for query. Specify two files separated by a
      space: -p file1 file2'
    inputBinding:
      position: 101
      prefix: --paired
  - id: single_end_reads
    type:
      - 'null'
      - File
    doc: 'Single-end reads to be used for query. Specify one file: -s file'
    inputBinding:
      position: 101
      prefix: --single
outputs:
  - id: output_file
    type: File
    doc: 'Output file to store the results. Specify an output file: -o output'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
