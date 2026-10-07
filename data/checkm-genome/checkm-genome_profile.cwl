cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - profile
label: checkm-genome_profile
doc: "Calculate percentage of reads mapped to each bin.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: coverage_file
    type: File
    doc: 'file indicating coverage of each sequence (see coverage command)'
    inputBinding:
      position: 1
  - id: file
    type:
      - 'null'
      - string
    doc: 'print results to file (default: stdout)'
    inputBinding:
      position: 101
      prefix: --file
  - id: tab_table
    type:
      - 'null'
      - boolean
    doc: 'print tab-separated values table'
    inputBinding:
      position: 101
      prefix: --tab_table
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: file_out
    type:
      - 'null'
      - File
    doc: 'print results to file (default: stdout)'
    outputBinding:
      glob: $(inputs.file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_profile.out
