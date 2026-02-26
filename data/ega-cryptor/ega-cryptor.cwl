cwlVersion: v1.2
class: CommandLineTool
baseCommand: ega-cryptor
label: ega-cryptor
doc: "EgaCryptorApplication v2.0.0\n\nTool homepage: https://ega-archive.org/submission/data/file-preparation/egacryptor/"
inputs:
  - id: input_files
    type:
      type: array
      items: string
    doc: File(s) to encrypt. Provide file/folder path or comma separated file 
      path if multiple files in double quotes
    inputBinding:
      position: 101
      prefix: -i
  - id: max_threads_50_percent_capacity
    type:
      - 'null'
      - boolean
    doc: Set this option to allow application to create maximum threads equals 
      to 50% capacity of cores/processors available on machine
    inputBinding:
      position: 101
      prefix: -l
  - id: max_threads_75_percent_capacity
    type:
      - 'null'
      - boolean
    doc: Set this option to allow application to create maximum threads equals 
      to 75% capacity of cores/processors available on machine
    inputBinding:
      position: 101
      prefix: -m
  - id: max_threads_full_capacity
    type:
      - 'null'
      - boolean
    doc: Set this option to allow application to create maximum threads to 
      utilize full capacity of cores/processors available on machine
    inputBinding:
      position: 101
      prefix: -f
  - id: max_threads_specified
    type:
      - 'null'
      - int
    doc: Set this option if user wants to control application to create maximum 
      threads as specified. Application will calculate no. of cores/processors 
      available on machine & will create threads accordingly
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Path of the output file. This is optional. If not provided then output files
      will be generated in the same path as that of source file (default: output-files)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ega-cryptor:2.0.0--hdfd78af_0
