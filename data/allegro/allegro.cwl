cwlVersion: v1.2
class: CommandLineTool
baseCommand: allegro
label: allegro
doc: "allegro 2.0f\n\nTool homepage: http://www.nature.com/ng/journal/v37/n10/full/ng1005-1015.html?foxtrotcallback=true"
inputs:
  - id: options_file
    type: File
    doc: Options file
    inputBinding:
      position: 1
  - id: m_flag
    type:
      - 'null'
      - boolean
    doc: m flag
    inputBinding:
      position: 102
      prefix: -m
  - id: n_flag
    type:
      - 'null'
      - boolean
    doc: n flag
    inputBinding:
      position: 102
      prefix: -n
  - id: t_flag
    type:
      - 'null'
      - boolean
    doc: t flag
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allegro:3--h077b44d_10
