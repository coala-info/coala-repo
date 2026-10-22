cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - check
label: seqfu_check
doc: "Check the integrity of FASTQ files, returns non zero\n  if an error occurs. Will print a table with\
  \ a report.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: fqfile
    type:
      - 'null'
      - File
    doc: the forward read file
    inputBinding:
      position: 1
  - id: rev
    type:
      - 'null'
      - File
    doc: the reverse read file
    inputBinding:
      position: 2
  - id: dir
    type:
      - 'null'
      - Directory
    doc: the directory containing the FASTQ files
    inputBinding:
      position: 102
      prefix: --dir
  - id: deep
    type:
      - 'null'
      - boolean
    doc: Perform a deep check of the file and will not support multiline Sanger FASTQ
    inputBinding:
      position: 102
      prefix: --deep
  - id: no_paired
    type:
      - 'null'
      - boolean
    doc: Disable autodetection of second pair
    inputBinding:
      position: 102
      prefix: --no-paired
  - id: safe_exit
    type:
      - 'null'
      - boolean
    doc: Exit with 0 even if errors are found
    inputBinding:
      position: 102
      prefix: --safe-exit
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print infos, just exit status
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: thousands
    type:
      - 'null'
      - boolean
    doc: Print numbers with thousands separator
    inputBinding:
      position: 102
      prefix: --thousands
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_check.out
