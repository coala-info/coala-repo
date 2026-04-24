cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-stat
label: parallel-fastq-dump_sra-stat
doc: "Display table statistics\n\nTool homepage: https://github.com/rvalieris/parallel-fastq-dump"
inputs:
  - id: table
    type: string
    doc: The table to display statistics for
    inputBinding:
      position: 1
  - id: alignment
    type:
      - 'null'
      - string
    doc: print alignment info (on | off)
    inputBinding:
      position: 102
      prefix: --alignment
  - id: archive_info
    type:
      - 'null'
      - boolean
    doc: output archive info, default is off
    inputBinding:
      position: 102
      prefix: --archive-info
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of (fatal|sys|int|err|warn|info|debug)
      or (0-6)
    inputBinding:
      position: 102
      prefix: --log-level
  - id: member_stats
    type:
      - 'null'
      - string
    doc: print member stats (on | off)
    inputBinding:
      position: 102
      prefix: --member-stats
  - id: meta
    type:
      - 'null'
      - boolean
    doc: print load metadata
    inputBinding:
      position: 102
      prefix: --meta
  - id: ngc
    type:
      - 'null'
      - File
    doc: path to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
  - id: quick
    type:
      - 'null'
      - boolean
    doc: 'quick mode: get statistics from metadata; do not scan the table'
    inputBinding:
      position: 102
      prefix: --quick
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show the percentage of completion
    inputBinding:
      position: 102
      prefix: --show_progress
  - id: start
    type:
      - 'null'
      - int
    doc: starting spot id
    inputBinding:
      position: 102
      prefix: --start
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: calculate READ_LEN average and standard deviation
    inputBinding:
      position: 102
      prefix: --statistics
  - id: stop
    type:
      - 'null'
      - int
    doc: ending spot id, default is max
    inputBinding:
      position: 102
      prefix: --stop
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase the verbosity of the program status messages. Use multiple times
      for more verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: xml
    type:
      - 'null'
      - boolean
    doc: output as XML, default is text
    inputBinding:
      position: 102
      prefix: --xml
outputs:
  - id: xml_log
    type:
      - 'null'
      - File
    doc: produce XML-formatted log file
    outputBinding:
      glob: $(inputs.xml_log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
