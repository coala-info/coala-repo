cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsim
label: pbsim2_pbsim
doc: "Simulator for long-read sequencers (PacBio and Nanopore)\n\nTool homepage: https://github.com/yukiteruono/pbsim2"
inputs:
  - id: reference
    type: File
    doc: FASTA format file (text file only).
    inputBinding:
      position: 1
  - id: accuracy_max
    type:
      - 'null'
      - float
    doc: maximum accuracy
    inputBinding:
      position: 102
      prefix: --accuracy-max
  - id: accuracy_mean
    type:
      - 'null'
      - float
    doc: mean of accuracy model
    inputBinding:
      position: 102
      prefix: --accuracy-mean
  - id: accuracy_min
    type:
      - 'null'
      - float
    doc: minimum accuracy
    inputBinding:
      position: 102
      prefix: --accuracy-min
  - id: depth
    type:
      - 'null'
      - float
    doc: depth of coverage
    inputBinding:
      position: 102
      prefix: --depth
  - id: difference_ratio
    type:
      - 'null'
      - string
    doc: ratio of differences (substitution:insertion:deletion). Each value must be
      0-1000.
    inputBinding:
      position: 102
      prefix: --difference-ratio
  - id: hmm_model
    type:
      - 'null'
      - File
    doc: HMM model of quality code.
    inputBinding:
      position: 102
      prefix: --hmm_model
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: prefix of read ID
    inputBinding:
      position: 102
      prefix: --id-prefix
  - id: length_max
    type:
      - 'null'
      - int
    doc: maximum length
    inputBinding:
      position: 102
      prefix: --length-max
  - id: length_mean
    type:
      - 'null'
      - float
    doc: mean of length model
    inputBinding:
      position: 102
      prefix: --length-mean
  - id: length_min
    type:
      - 'null'
      - int
    doc: minimum length
    inputBinding:
      position: 102
      prefix: --length-min
  - id: length_sd
    type:
      - 'null'
      - float
    doc: standard deviation of length model
    inputBinding:
      position: 102
      prefix: --length-sd
  - id: sample_fastq
    type:
      - 'null'
      - File
    doc: FASTQ format file to sample (text file only).
    inputBinding:
      position: 102
      prefix: --sample-fastq
  - id: sample_profile_id
    type:
      - 'null'
      - string
    doc: sample-fastq (filtered) profile ID. When using --sample-fastq, profile is
      stored.
    inputBinding:
      position: 102
      prefix: --sample-profile-id
  - id: seed
    type:
      - 'null'
      - int
    doc: for a pseudorandom number generator (Unix time).
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
    dockerPull: quay.io/biocontainers/pbsim2:2.0.1--h9948957_4
