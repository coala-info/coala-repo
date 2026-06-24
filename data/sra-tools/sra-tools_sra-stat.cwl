cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-stat
label: sra-tools_sra-stat
doc: Display table statistics
inputs:
  - id: table
    type: string
    doc: The table to display statistics for
    inputBinding:
      position: 1
  - id: xml
    type:
      - 'null'
      - boolean
    doc: Output as XML, default is text.
    inputBinding:
      position: 102
      prefix: --xml
  - id: start
    type:
      - 'null'
      - int
    doc: Starting spot id, default is 1.
    inputBinding:
      position: 102
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Ending spot id, default is max.
    inputBinding:
      position: 102
      prefix: --stop
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Print load metadata.
    inputBinding:
      position: 102
      prefix: --meta
  - id: quick
    type:
      - 'null'
      - boolean
    doc: 'Quick mode: get statistics from metadata; do not scan the table.'
    inputBinding:
      position: 102
      prefix: --quick
  - id: member_stats
    type:
      - 'null'
      - string
    doc: Print member stats, default is on.
    inputBinding:
      position: 102
      prefix: --member-stats
  - id: archive_info
    type:
      - 'null'
      - boolean
    doc: Output archive info, default is off.
    inputBinding:
      position: 102
      prefix: --archive-info
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: Calculate READ_LEN average and standard deviation.
    inputBinding:
      position: 102
      prefix: --statistics
  - id: alignment
    type:
      - 'null'
      - string
    doc: Print alignment info, default is on.
    inputBinding:
      position: 102
      prefix: --alignment
  - id: local_info
    type:
      - 'null'
      - boolean
    doc: Print the date, path, size and md5 of local run.
    inputBinding:
      position: 102
      prefix: --local-info
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Show the percentage of completion.
    inputBinding:
      position: 102
      prefix: --show_progress
  - id: ngc
    type: File
    doc: Path to ngc file.
    inputBinding:
      position: 102
      prefix: --ngc
  - id: xml_log
    type: string
    doc: Produce XML-formatted log file.
    inputBinding:
      position: 102
      prefix: --xml-log
  - id: repair_data
    type:
      - 'null'
      - boolean
    doc: Generate data for repair tool.
    inputBinding:
      position: 102
      prefix: --repair-data
  - id: info
    type:
      - 'null'
      - boolean
    doc: Print report for all fields examined for mismatch even if the old value
      is correct.
    inputBinding:
      position: 102
      prefix: --info
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of 
      (fatal|sys|int|err|warn|info|debug) or (0-6) Current/default is warn.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program. Negated by verbose.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
outputs:
  - id: output_xml_log
    type:
      - 'null'
      - File
    doc: Produce XML-formatted log file.
    outputBinding:
      glob: $(inputs.xml_log)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
s:url: https://github.com/ncbi/sra-tools
$namespaces:
  s: https://schema.org/
