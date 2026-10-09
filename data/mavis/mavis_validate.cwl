cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mavis
  - validate
label: mavis_validate
doc: "Validate MAVIS inputs and outputs.\n\nTool homepage: https://github.com/bcgsc/mavis.git"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_files || [])
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: path to the input files
    inputBinding:
      position: 101
      prefix: --inputs
  - id: config
    type: File
    doc: path to the JSON config file
    inputBinding:
      position: 102
      prefix: --config
  - id: reference_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (reference genome, annotations, BAM files
      and their indexes, ...). They are staged in the working directory so the 
      relative paths in the config resolve.
  - id: library
    type: string
    doc: The library to run the current step on
    inputBinding:
      position: 103
      prefix: --library
  - id: log
    type:
      - 'null'
      - string
    doc: redirect stdout to a log file
    inputBinding:
      position: 104
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    inputBinding:
      position: 104
      prefix: --log_level
  - id: output_path
    type: string
    doc: path to the output directory
    inputBinding:
      position: 105
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
