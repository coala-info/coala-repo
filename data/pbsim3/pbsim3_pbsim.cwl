cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsim
label: pbsim3_pbsim
doc: "Simulator for long-read sequencers (PacBio and ONT)\n\nTool homepage: https://github.com/yukiteruono/pbsim3"
inputs:
  - id: accuracy_max
    type:
      - 'null'
      - float
    doc: maximum accuracy
    default: 1.0
    inputBinding:
      position: 101
      prefix: --accuracy-max
  - id: accuracy_mean
    type:
      - 'null'
      - float
    doc: mean accuracy
    default: 0.85
    inputBinding:
      position: 101
      prefix: --accuracy-mean
  - id: accuracy_min
    type:
      - 'null'
      - float
    doc: minimum accuracy
    default: 0.75
    inputBinding:
      position: 101
      prefix: --accuracy-min
  - id: depth
    type:
      - 'null'
      - float
    doc: depth of coverage
    default: 20.0
    inputBinding:
      position: 101
      prefix: --depth
  - id: difference_ratio
    type:
      - 'null'
      - string
    doc: difference (error) ratio (substitution:insertion:deletion)
    default: 6:55:39
    inputBinding:
      position: 101
      prefix: --difference-ratio
  - id: errhmm
    type:
      - 'null'
      - File
    doc: error model
    inputBinding:
      position: 101
      prefix: --errhmm
  - id: genome
    type:
      - 'null'
      - File
    doc: FASTA format file (text file only) for WGS strategy
    inputBinding:
      position: 101
      prefix: --genome
  - id: hp_del_bias
    type:
      - 'null'
      - int
    doc: bias intensity of deletion in homopolymer
    default: 1
    inputBinding:
      position: 101
      prefix: --hp-del-bias
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: prefix of read ID
    default: S
    inputBinding:
      position: 101
      prefix: --id-prefix
  - id: length_max
    type:
      - 'null'
      - int
    doc: maximum length
    default: 1000000
    inputBinding:
      position: 101
      prefix: --length-max
  - id: length_mean
    type:
      - 'null'
      - float
    doc: mean length
    default: 9000.0
    inputBinding:
      position: 101
      prefix: --length-mean
  - id: length_min
    type:
      - 'null'
      - int
    doc: minimum length
    default: 100
    inputBinding:
      position: 101
      prefix: --length-min
  - id: length_sd
    type:
      - 'null'
      - float
    doc: standard deviation of length
    default: 7000.0
    inputBinding:
      position: 101
      prefix: --length-sd
  - id: method
    type:
      - 'null'
      - string
    doc: model method (qshmm or errhmm)
    inputBinding:
      position: 101
      prefix: --method
  - id: pass_num
    type:
      - 'null'
      - int
    doc: number of sequencing passes
    default: 1
    inputBinding:
      position: 101
      prefix: --pass-num
  - id: qshmm
    type:
      - 'null'
      - File
    doc: quality score model
    inputBinding:
      position: 101
      prefix: --qshmm
  - id: sample
    type:
      - 'null'
      - File
    doc: FASTQ format file to sample (text file only)
    inputBinding:
      position: 101
      prefix: --sample
  - id: sample_profile_id
    type:
      - 'null'
      - string
    doc: sample (filtered) profile ID
    inputBinding:
      position: 101
      prefix: --sample-profile-id
  - id: seed
    type:
      - 'null'
      - int
    doc: for a pseudorandom number generator (Unix time)
    inputBinding:
      position: 101
      prefix: --seed
  - id: strategy
    type:
      - 'null'
      - string
    doc: sequencing strategy (wgs, trans, or templ)
    inputBinding:
      position: 101
      prefix: --strategy
  - id: template
    type:
      - 'null'
      - File
    doc: FASTA format file (text file only) for template sequencing
    inputBinding:
      position: 101
      prefix: --template
  - id: transcript
    type:
      - 'null'
      - File
    doc: original format file for transcriptome sequencing
    inputBinding:
      position: 101
      prefix: --transcript
outputs:
  - id: prefix
    type:
      - 'null'
      - File
    doc: prefix of output files
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbsim3:3.0.5--h9948957_2
