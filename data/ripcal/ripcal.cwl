cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripcal
label: ripcal
doc: "RIPCAL help...\n\nTool homepage: https://sourceforge.net/projects/ripcal"
inputs:
  - id: alignment_model
    type:
      - 'null'
      - string
    doc: Alignment model [gc|consensus|user]
    default: gc
    inputBinding:
      position: 101
      prefix: -m
  - id: analysis_type
    type:
      - 'null'
      - string
    doc: RIP analysis type [align|index|scan]
    default: align
    inputBinding:
      position: 101
      prefix: -t
  - id: command_line_interface
    type:
      - 'null'
      - boolean
    doc: use command line interface
    inputBinding:
      position: 101
      prefix: -c
  - id: cpA_tpG_apC_gpT_threshold
    type:
      - 'null'
      - float
    doc: CpA+TpG/ApC+GpT threshold
    default: 1.03
    inputBinding:
      position: 101
      prefix: -w
  - id: cpA_tpG_tpA_threshold
    type:
      - 'null'
      - float
    doc: CpA+TpG/TpA threshold
    inputBinding:
      position: 101
      prefix: -e
  - id: cpC_gpG_tpC_gpA_threshold
    type:
      - 'null'
      - float
    doc: CpC+GpG/TpC+GpA threshold
    inputBinding:
      position: 101
      prefix: -r
  - id: cpg_tpg_cpa_threshold
    type:
      - 'null'
      - float
    doc: CpG/TpG+CpA threshold
    inputBinding:
      position: 101
      prefix: -y
  - id: cpt_apg_tpt_apa_threshold
    type:
      - 'null'
      - float
    doc: CpT+ApG/TpT+ApA threshold
    inputBinding:
      position: 101
      prefix: -u
  - id: input_gff_file
    type:
      - 'null'
      - File
    doc: input gff file
    inputBinding:
      position: 101
      prefix: -g
  - id: input_sequence_file
    type: File
    doc: input sequence file [fasta or clustalw format]
    inputBinding:
      position: 101
      prefix: -s
  - id: scanning_subsequence_increment
    type:
      - 'null'
      - int
    doc: Scanning subsequence increment
    default: 150
    inputBinding:
      position: 101
      prefix: -i
  - id: scanning_subsequence_length
    type:
      - 'null'
      - int
    doc: Length of scanning subsequence
    default: 300
    inputBinding:
      position: 101
      prefix: -l
  - id: tpA_apT_threshold
    type:
      - 'null'
      - float
    doc: TpA/ApT threshold
    default: 0.89
    inputBinding:
      position: 101
      prefix: -q
  - id: windowsize
    type:
      - 'null'
      - int
    doc: Alignment RIP frequency graph window
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ripcal:2.0--hdfd78af_0
stdout: ripcal.out
