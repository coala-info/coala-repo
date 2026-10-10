cwlVersion: v1.2
class: CommandLineTool
baseCommand: ts
label: moreutils_ts
doc: "Timestamp standard input. Adds a timestamp to the beginning of each line of
  input, using strftime format (default %b %d %H:%M:%S).\n\nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: strftime format string for the timestamp.
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: File sent to the standard input of ts.
  - id: relative
    type:
      - 'null'
      - boolean
    doc: Convert existing timestamps in the input to relative times.
    inputBinding:
      position: 1
      prefix: -r
  - id: incremental
    type:
      - 'null'
      - boolean
    doc: Timestamp each line with the time since the previous line.
    inputBinding:
      position: 1
      prefix: -i
  - id: since_start
    type:
      - 'null'
      - boolean
    doc: Timestamp each line with the time since the start of the program.
    inputBinding:
      position: 1
      prefix: -s
  - id: monotonic
    type:
      - 'null'
      - boolean
    doc: Use the monotonic clock, for -i and -s.
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdin: $(inputs.input_file.path)
stdout: moreutils_ts.out
