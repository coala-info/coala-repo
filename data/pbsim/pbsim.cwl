cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsim
label: pbsim
doc: "PacBio read simulator for sampling-based or model-based simulation\n\nTool homepage:
  https://github.com/yukiteruono/pbsim3"
inputs:
  - id: reference
    type: File
    doc: FASTA format file
    inputBinding:
      position: 1
  - id: accuracy_max
    type:
      - 'null'
      - float
    doc: 'maximum accuracy. (CLR: 1.00, CCS: fixed as 1.00). this option can be used
      only in case of CLR.'
    inputBinding:
      position: 102
      prefix: --accuracy-max
  - id: accuracy_mean
    type:
      - 'null'
      - float
    doc: 'mean of accuracy model. (CLR: 0.78, CCS: fixed as 0.98). this option can
      be used only in case of CLR.'
    inputBinding:
      position: 102
      prefix: --accuracy-mean
  - id: accuracy_min
    type:
      - 'null'
      - float
    doc: 'minimum accuracy. (CLR: 0.75, CCS: fixed as 0.75). this option can be used
      only in case of CLR.'
    inputBinding:
      position: 102
      prefix: --accuracy-min
  - id: accuracy_sd
    type:
      - 'null'
      - float
    doc: 'standard deviation of accuracy model. (CLR: 0.02, CCS: fixed as 0.02). this
      option can be used only in case of CLR.'
    inputBinding:
      position: 102
      prefix: --accuracy-sd
  - id: data_type
    type:
      - 'null'
      - string
    doc: data type. CLR or CCS
    default: CLR
    inputBinding:
      position: 102
      prefix: --data-type
  - id: depth
    type:
      - 'null'
      - float
    doc: 'depth of coverage (CLR: 20.0, CCS: 50.0)'
    inputBinding:
      position: 102
      prefix: --depth
  - id: difference_ratio
    type:
      - 'null'
      - string
    doc: 'ratio of differences. substitution:insertion:deletion. each value up to
      1000 (CLR: 10:60:30, CCS:6:21:73).'
    inputBinding:
      position: 102
      prefix: --difference-ratio
  - id: length_max
    type:
      - 'null'
      - int
    doc: 'maximum length (CLR: 25000, CCS: 2500)'
    inputBinding:
      position: 102
      prefix: --length-max
  - id: length_mean
    type:
      - 'null'
      - float
    doc: 'mean of length model (CLR: 3000.0, CCS:450.0)'
    inputBinding:
      position: 102
      prefix: --length-mean
  - id: length_min
    type:
      - 'null'
      - int
    doc: minimum length
    default: 100
    inputBinding:
      position: 102
      prefix: --length-min
  - id: length_sd
    type:
      - 'null'
      - float
    doc: 'standard deviation of length model. (CLR: 2300.0, CCS: 170.0)'
    inputBinding:
      position: 102
      prefix: --length-sd
  - id: model_qc
    type:
      - 'null'
      - File
    doc: model of quality code
    inputBinding:
      position: 102
      prefix: --model_qc
  - id: sample_fastq
    type:
      - 'null'
      - File
    doc: FASTQ format file to sample
    inputBinding:
      position: 102
      prefix: --sample-fastq
  - id: sample_profile_id
    type:
      - 'null'
      - string
    doc: sample-fastq (filtered) profile ID. when using --sample-fastq, profile is
      stored. when not using --sample-fastq, profile is re-used.
    inputBinding:
      position: 102
      prefix: --sample-profile-id
  - id: seed
    type:
      - 'null'
      - int
    doc: for a pseudorandom number generator (Unix time)
    inputBinding:
      position: 102
      prefix: --seed
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
    dockerPull: biocontainers/pbsim:v1.0.3-2-deb_cv1
