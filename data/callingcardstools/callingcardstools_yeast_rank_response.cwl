cwlVersion: v1.2
class: CommandLineTool
baseCommand: yeast_rank_response
label: callingcardstools_yeast_rank_response
doc: "Rank response of yeast genes based on calling cards data.\n\nTool homepage:
  https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output file using gzip
    inputBinding:
      position: 101
      prefix: --compress
  - id: config
    type: File
    doc: Path to the configuration json file. For details, see 
      https://cmatkhan.github.io/callingCardsTools/file_format_specs/yeast_rank_response/
    inputBinding:
      position: 101
      prefix: --config
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file. Default is rank_response.csv
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
