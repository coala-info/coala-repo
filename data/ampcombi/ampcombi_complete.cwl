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
    doc: Enter a directory path in which summaries are in samples directories, 
      e.g. './ampcombi_parse_tables/'
    inputBinding:
      position: 101
      prefix: --summaries_directory
  - id: summaries_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Enter a list of samples' ampcombi summaries, e.g. 
      ./ampcombi/sample_1/sample_1_ampcombi.tsv ./ampcombi/sample_2_ampcombi.tsv
    inputBinding:
      position: 101
      prefix: --summaries_files
  - id: log
    type:
      - 'null'
      - boolean
    doc: Silence the standard output and capture it in a log file with a fixed 
      name.
    inputBinding:
      position: 102
      prefix: --log
      valueFrom: '$(self ? "True" : null)'
outputs:
  - id: summary
    type: File
    doc: Combined AMPcombi summary of all samples
    outputBinding:
      glob: Ampcombi_summary.tsv
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written when log is set
    outputBinding:
      glob: Ampcombi_complete.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
