cwlVersion: v1.2
class: CommandLineTool
baseCommand: query
label: ntstat_query
doc: "Query ntstat database\n\nTool homepage: https://github.com/bcgsc/ntStat"
inputs:
  - id: data
    type:
      type: array
      items: File
    doc: path to query data
    inputBinding:
      position: 1
  - id: bf_cbf_file
    type: File
    doc: path to BF/CBF file
    inputBinding:
      position: 102
      prefix: -b
  - id: spaced_seeds_file
    type:
      - 'null'
      - File
    doc: path to spaced seeds file
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_tsv_file
    type: File
    doc: path to output TSV file
    outputBinding:
      glob: $(inputs.output_tsv_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
