cwlVersion: v1.2
class: CommandLineTool
baseCommand: f5ls
label: fast5_f5ls
doc: "Summarize contents of ONT fast5 files.\n\nTool homepage: https://github.com/mateidavid/fast5"
inputs:
  - id: inputs
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Input directories, fast5 files, or files of fast5 file names.
    inputBinding:
      position: 1
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Log level (default: warning).'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: delim
    type:
      - 'null'
      - string
    doc: 'Delimiters list; first char used between path and value, second char used
      between path elements (default: tab and slash).'
    inputBinding:
      position: 102
      prefix: --delim
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse in input directories.
    inputBinding:
      position: 102
      prefix: --recurse
outputs:
  - id: summary
    type: stdout
    doc: Summary of the contents of the fast5 files.
stdout: fast5_f5ls.out
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fast5:v0.6.5-2-deb_cv1
