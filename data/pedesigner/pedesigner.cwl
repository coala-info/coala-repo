cwlVersion: v1.2
class: CommandLineTool
baseCommand: pedesigner
label: pedesigner
doc: "A tool for designing prime editing guide RNAs (pegRNAs).\n\nTool homepage: https://github.com/VeredKunik/pedesigner"
inputs:
  - id: ref_directory
    type: File
    doc: Path of reference sequence file in FASTA format
    inputBinding:
      position: 1
  - id: ind_directory
    type: File
    doc: Path of reference sequence file in FASTA format
    inputBinding:
      position: 2
  - id: pam
    type: string
    doc: PAM sequence
    inputBinding:
      position: 3
  - id: ref_dir
    type: Directory
    doc: Directory of reference genome file, in FASTA or 2bit format
    inputBinding:
      position: 4
  - id: mismatch_number
    type:
      - 'null'
      - int
    doc: Mismatch number
    inputBinding:
      position: 105
      prefix: -m
  - id: nick_max
    type:
      - 'null'
      - int
    doc: Maximum of nicking distance
    inputBinding:
      position: 105
      prefix: --nick_max
  - id: nick_min
    type:
      - 'null'
      - int
    doc: Minimum of nicking distance
    inputBinding:
      position: 105
      prefix: --nick_min
  - id: pbs_max
    type:
      - 'null'
      - int
    doc: Maximum of PBS length
    inputBinding:
      position: 105
      prefix: --pbs_max
  - id: pbs_min
    type:
      - 'null'
      - int
    doc: Minimum of PBS length
    inputBinding:
      position: 105
      prefix: --pbs_min
  - id: rtt_max
    type:
      - 'null'
      - int
    doc: Maximum of RTT length
    inputBinding:
      position: 105
      prefix: --rtt_max
  - id: rtt_min
    type:
      - 'null'
      - int
    doc: Minimum of RTT length
    inputBinding:
      position: 105
      prefix: --rtt_min
  - id: target_length
    type:
      - 'null'
      - int
    doc: length of target without PAM
    inputBinding:
      position: 105
      prefix: -l
  - id: use_cpus
    type:
      - 'null'
      - boolean
    doc: Use cpu instead of gpu (cas-offinder)
    inputBinding:
      position: 105
      prefix: --use_cpus
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pedesigner:0.2.0--pyhdfd78af_0
stdout: pedesigner.out
