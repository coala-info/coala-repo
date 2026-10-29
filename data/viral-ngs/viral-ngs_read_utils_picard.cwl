cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - picard
label: viral-ngs_read_utils_picard
doc: "Generic Picard runner.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: command
    type: string
    doc: "picard command"
    inputBinding:
      position: 1
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 2g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
  - id: picard_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Optional arguments to Picard, OPTIONNAME=value ..."
    inputBinding:
      position: 30
      prefix: --picardOptions
  - id: input_files
    type:
      type: array
      items: File
    doc: "Files named in picard_options, staged in the working directory so that the names resolve."
outputs:
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files written by the Picard command"
    outputBinding:
      glob: '*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
