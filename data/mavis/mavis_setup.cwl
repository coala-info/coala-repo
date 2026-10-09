cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mavis
  - setup
label: mavis_setup
doc: "Setup Mavis\n\nTool homepage: https://github.com/bcgsc/mavis.git"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_files || [])
inputs:
  - id: config
    type: File
    doc: path to the JSON config file
    inputBinding:
      position: 101
      prefix: --config
  - id: reference_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (reference genome, annotations, BAM files
      and their indexes, ...). They are staged in the working directory so the 
      relative paths in the config resolve.
  - id: log
    type:
      - 'null'
      - string
    doc: redirect stdout to a log file
    inputBinding:
      position: 101
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    inputBinding:
      position: 101
      prefix: --log_level
  - id: outputfile_path
    type: string
    inputBinding:
      position: 102
      prefix: --outputfile
outputs:
  - id: outputfile
    type: File
    doc: path to the outputfile
    outputBinding:
      glob: $(inputs.outputfile_path)
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
