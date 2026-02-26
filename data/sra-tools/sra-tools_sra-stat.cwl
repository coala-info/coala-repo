cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-stat
label: sra-tools_sra-stat
doc: "Display table statistics\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs:
  - id: table
    type: string
    doc: Table to display statistics for
    inputBinding:
      position: 1
  - id: alignment
    type:
      - 'null'
      - string
    doc: Print alignment info
    default: on
    inputBinding:
      position: 102
      prefix: --alignment
  - id: archive_info
    type:
      - 'null'
      - boolean
    doc: Output archive info
    default: false
    inputBinding:
      position: 102
      prefix: --archive-info
  - id: info
    type:
      - 'null'
      - boolean
    doc: Print report for all fields examined for mismatch even if the old value
      is correct.
    inputBinding:
      position: 102
      prefix: --info
  - id: local_info
    type:
      - 'null'
      - boolean
    doc: Print the date, path, size and md5 of local run.
    inputBinding:
      position: 102
      prefix: --local-info
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of 
      (fatal|sys|int|err|warn|info|debug) or (0-6)
    default: warn
    inputBinding:
      position: 102
      prefix: --log-level
  - id: member_stats
    type:
      - 'null'
      - string
    doc: Print member stats
    default: on
    inputBinding:
      position: 102
      prefix: --member-stats
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Print load metadata.
    inputBinding:
      position: 102
      prefix: --meta
  - id: ngc
    type:
      - 'null'
      - File
    doc: Path to ngc file.
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
    doc: 'Quick mode: get statistics from metadata; do not scan the table.'
    inputBinding:
      position: 102
      prefix: --quick
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program. Negated by verbose.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: repair_data
    type:
      - 'null'
      - boolean
    doc: Generate data for repair tool.
    inputBinding:
      position: 102
      prefix: --repair-data
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Show the percentage of completion.
    inputBinding:
      position: 102
      prefix: --show_progress
  - id: start
    type:
      - 'null'
      - string
    doc: Starting spot id
    default: '1'
    inputBinding:
      position: 102
      prefix: --start
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: Calculate READ_LEN average and standard deviation.
    inputBinding:
      position: 102
      prefix: --statistics
  - id: stop
    type:
      - 'null'
      - string
    doc: Ending spot id
    default: max
    inputBinding:
      position: 102
      prefix: --stop
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of the program status messages. Use multiple 
      times for more verbosity. Negates quiet.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: xml
    type:
      - 'null'
      - boolean
    doc: Output as XML, default is text.
    inputBinding:
      position: 102
      prefix: --xml
  - id: xml_log
    type:
      - 'null'
      - File
    doc: Produce XML-formatted log file.
    inputBinding:
      position: 102
      prefix: --xml-log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_sra-stat.out
