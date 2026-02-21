cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ampcombi
  - complete
label: ampcombi_complete
doc: "Complete the ampcombi analysis by aggregating summary files from a directory
  or a list of files.\n\nTool homepage: https://github.com/Darcy220606/AMPcombi"
inputs:
  - id: summaries_directory
    type:
      - 'null'
      - Directory
    doc: Enter a directory path in which summaries are in samples directories, e.g.
      './ampcombi_parse_tables/'
    inputBinding:
      position: 101
      prefix: --summaries_directory
  - id: summaries_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Enter a list of samples' ampcombi summaries, e.g. ./ampcombi/sample_1/sample_1_ampcombi.tsv
      ./ampcombi/sample_2_ampcombi.tsv
    inputBinding:
      position: 101
      prefix: --summaries_files
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Silences the standard output and captures it in a log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
