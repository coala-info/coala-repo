cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis_convert
label: mavis_convert
doc: "Convert structural variant calls from various callers into a common format.\n\
  \nTool homepage: https://github.com/bcgsc/mavis.git"
inputs:
  - id: assume_no_untemplated
    type:
      - 'null'
      - boolean
    doc: If True, assume no untemplated insertions. If False, do not make this 
      assumption.
    inputBinding:
      position: 101
  - id: file_type
    type: string
    doc: Indicates the input file type to be parsed
    inputBinding:
      position: 101
  - id: inputs
    type:
      type: array
      items: File
    doc: path to the input files
    inputBinding:
      position: 101
      prefix: --inputs
  - id: log
    type:
      - 'null'
      - File
    doc: redirect stdout to a log file
    inputBinding:
      position: 101
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    default: INFO
    inputBinding:
      position: 101
      prefix: --log_level
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: If True, assume strand specificity. If False, do not assume strand 
      specificity.
    inputBinding:
      position: 101
outputs:
  - id: outputfile
    type: File
    doc: path to the outputfile
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
