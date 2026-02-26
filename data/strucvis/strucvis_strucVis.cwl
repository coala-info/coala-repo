cwlVersion: v1.2
class: CommandLineTool
baseCommand: strucVis
label: strucvis_strucVis
doc: "strucVis\n\nTool homepage: https://github.com/MikeAxtell/strucVis"
inputs:
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Program arguments
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: BAM file
    inputBinding:
      position: 102
      prefix: -b
  - id: c_option
    type:
      - 'null'
      - string
    doc: Option -c
    inputBinding:
      position: 102
      prefix: -c
  - id: g_option
    type:
      - 'null'
      - string
    doc: Option -g
    inputBinding:
      position: 102
      prefix: -g
  - id: h_flag
    type:
      - 'null'
      - boolean
    doc: Boolean option -h
    inputBinding:
      position: 102
      prefix: -h
  - id: n_option
    type:
      - 'null'
      - string
    doc: Option -n
    inputBinding:
      position: 102
      prefix: -n
  - id: p_option
    type:
      - 'null'
      - string
    doc: Option -p
    inputBinding:
      position: 102
      prefix: -p
  - id: s_option
    type:
      - 'null'
      - string
    doc: Option -s
    inputBinding:
      position: 102
      prefix: -s
  - id: v_flag
    type:
      - 'null'
      - boolean
    doc: Boolean option -v
    inputBinding:
      position: 102
      prefix: -v
  - id: x_flag
    type:
      - 'null'
      - boolean
    doc: Boolean option -x
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strucvis:0.9--hdfd78af_0
stdout: strucvis_strucVis.out
