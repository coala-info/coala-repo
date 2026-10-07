cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - callingcardstools
  - yeast_rank_response
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
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Binding and expression data files named in the config json. They are 
      staged in the working directory, so the config should name them by file 
      name only.
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level
    inputBinding:
      position: 101
      prefix: --log_level
  - id: output_file_path
    type: string?
    inputBinding:
      position: 102
      prefix: --output_file
outputs:
  - id: output_file
    type: File
    doc: Rank response table (csv, gzipped with --compress)
    outputBinding:
      glob: '$(inputs.output_file_path ? inputs.output_file_path : "rank_response.csv")$(inputs.compress
        && !(inputs.output_file_path || "").endsWith(".gz") ? ".gz" : "")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.data_files ? inputs.data_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
