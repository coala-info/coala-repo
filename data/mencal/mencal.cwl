cwlVersion: v1.2
class: CommandLineTool
baseCommand: mencal
label: mencal
doc: "Menstruation calendar 2.1\n\nTool homepage: https://github.com/felgari/mencal"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: actual_month
    type:
      - 'null'
      - boolean
    doc: actual month (default)
    inputBinding:
      position: 102
      prefix: '-1'
  - id: all_year
    type:
      - 'null'
      - int
    doc: all-year calendar (default YYYY is current year)
    inputBinding:
      position: 102
      prefix: -y
  - id: color
    type:
      - 'null'
      - boolean
    doc: colored output (default)
    inputBinding:
      position: 102
      prefix: --color
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Configuration files
    inputBinding:
      position: 102
      prefix: --config
  - id: config_menstruation_duration
    type:
      - 'null'
      - int
    doc: duration of menstruation in days (default 4)
    inputBinding:
      position: 102
  - id: config_period_length
    type:
      - 'null'
      - int
    doc: length of period in days (default 28)
    inputBinding:
      position: 102
  - id: config_save_file
    type:
      - 'null'
      - File
    doc: filename to save configuration to
    inputBinding:
      position: 102
  - id: config_start_date
    type:
      - 'null'
      - string
    doc: start day of period (default current day)
    inputBinding:
      position: 102
  - id: config_subject_color
    type:
      - 'null'
      - string
    doc: color used for menstruation days of subject
    inputBinding:
      position: 102
  - id: config_subject_name
    type:
      - 'null'
      - string
    doc: name of subject
    inputBinding:
      position: 102
  - id: intersection_color
    type:
      - 'null'
      - string
    doc: intersection color (default red)
    inputBinding:
      position: 102
      prefix: --icolor
  - id: monday
    type:
      - 'null'
      - boolean
    doc: draw monday as first weekday (sunday is default)
    inputBinding:
      position: 102
      prefix: --monday
  - id: nocolor
    type:
      - 'null'
      - boolean
    doc: noncolored output
    inputBinding:
      position: 102
      prefix: --nocolor
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: no top information will be printed
    inputBinding:
      position: 102
      prefix: --quiet
  - id: three_months
    type:
      - 'null'
      - boolean
    doc: previous, current and next month
    inputBinding:
      position: 102
      prefix: '-3'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mencal:v3.0-4-deb_cv1
stdout: mencal.out
