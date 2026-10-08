cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - examine
  - info
label: gappa_examine_info
doc: "Print basic information about placement files.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: jplace_path
    type:
      type: array
      items:
        - File
        - Directory
    doc: "List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed."
    inputBinding:
      position: 1
      prefix: --jplace-path
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 2
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 3
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 4
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 5
      prefix: --log-file
outputs:
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
  - id: info_table
    type: stdout
    doc: Basic information about the placement files, printed to standard output.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
stdout: gappa_examine_info.out
