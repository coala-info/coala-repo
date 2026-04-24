cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpp-gerpcol
label: gerp_gerpcol
doc: "gpp-gerpcol options:\n\nTool homepage: http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html"
inputs:
  - id: alignment_filename
    type:
      - 'null'
      - File
    doc: alignment filename
    inputBinding:
      position: 101
      prefix: -f
  - id: alignment_mfa
    type:
      - 'null'
      - boolean
    doc: alignment in mfa format
    inputBinding:
      position: 101
      prefix: -a
  - id: force_start_at_zero
    type:
      - 'null'
      - boolean
    doc: force start at position 0
    inputBinding:
      position: 101
      prefix: -z
  - id: output_files_suffix
    type:
      - 'null'
      - string
    doc: suffix for naming output files
    inputBinding:
      position: 101
      prefix: -x
  - id: precision
    type:
      - 'null'
      - float
    doc: tolerance for rate estimation
    inputBinding:
      position: 101
      prefix: -p
  - id: project_out_reference
    type:
      - 'null'
      - boolean
    doc: project out reference sequence
    inputBinding:
      position: 101
      prefix: -j
  - id: reference_seq
    type:
      - 'null'
      - string
    doc: name of reference sequence
    inputBinding:
      position: 101
      prefix: -e
  - id: tr_tv_ratio
    type:
      - 'null'
      - float
    doc: Tr/Tv ratio
    inputBinding:
      position: 101
      prefix: -r
  - id: tree_filename
    type:
      - 'null'
      - File
    doc: evolutionary tree
    inputBinding:
      position: 101
      prefix: -t
  - id: tree_neutral_rate
    type:
      - 'null'
      - string
    doc: tree neutral rate
    inputBinding:
      position: 101
      prefix: -n
  - id: tree_scaling_factor
    type:
      - 'null'
      - float
    doc: tree scaling factor
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gerp:2.1--h1b792b2_2
stdout: gerp_gerpcol.out
