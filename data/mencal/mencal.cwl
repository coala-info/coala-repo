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
    doc: Configuration files to read (as written by the f= configuration option)
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
  - id: config
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -c
          separate: true
    doc: 'Menstruation configuration as one comma separated list without spaces,
      for example s=20260915,l=28,d=4,n=NAME,f=FILE,c=COLOR. May be given
      several times.'
    inputBinding:
      position: 102
  - id: config_menstruation_duration
    type:
      - 'null'
      - int
    doc: duration of menstruation in days (default 4); sent as d=DD in an extra
      -c option together with the other config_* inputs
  - id: config_period_length
    type:
      - 'null'
      - int
    doc: length of period in days (default 28); sent as l=LL in an extra -c
      option together with the other config_* inputs
  - id: config_save_file
    type:
      - 'null'
      - string
    doc: filename to save configuration to; sent as f=FILE in an extra -c option
      together with the other config_* inputs
  - id: config_start_date
    type:
      - 'null'
      - string
    doc: start day of period [YYYY]MMDD (default current day); sent as s=DATE in
      an extra -c option together with the other config_* inputs
  - id: config_subject_color
    type:
      - 'null'
      - string
    doc: color used for menstruation days of subject; sent as c=COLOR in an
      extra -c option together with the other config_* inputs
  - id: config_subject_name
    type:
      - 'null'
      - string
    doc: name of subject; sent as n=NAME in an extra -c option together with the
      other config_* inputs
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
arguments:
  - position: 101
    prefix: -c
    valueFrom: |
      ${
        var p = [];
        if (inputs.config_start_date) p.push('s=' + inputs.config_start_date);
        if (inputs.config_period_length !== null && inputs.config_period_length !== undefined) p.push('l=' + inputs.config_period_length);
        if (inputs.config_menstruation_duration !== null && inputs.config_menstruation_duration !== undefined) p.push('d=' + inputs.config_menstruation_duration);
        if (inputs.config_subject_name) p.push('n=' + inputs.config_subject_name);
        if (inputs.config_save_file) p.push('f=' + inputs.config_save_file);
        if (inputs.config_subject_color) p.push('c=' + inputs.config_subject_color);
        return p.length ? p.join(',') : null;
      }
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: saved_config
    type:
      - 'null'
      - File
    doc: Configuration file written when config_save_file is set
    outputBinding:
      glob: $(inputs.config_save_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mencal:v3.0-4-deb_cv1
stdout: mencal.out
