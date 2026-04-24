cwlVersion: v1.2
class: CommandLineTool
baseCommand: smashpp
label: smashpp
doc: "SMASH++: a fast and accurate tool for detecting structural variations in DNA
  sequences.\n\nTool homepage: https://github.com/smortezah/smashpp"
inputs:
  - id: asymmetric_regions
    type:
      - 'null'
      - boolean
    doc: 'consider asymmetric regions. Default: not used'
    inputBinding:
      position: 101
      prefix: --asymmetric-regions
  - id: entropy_n
    type:
      - 'null'
      - float
    doc: "entropy of 'N's: 0.0 to 100.0."
    inputBinding:
      position: 101
      prefix: --entropy-N
  - id: filter_scale
    type:
      - 'null'
      - string
    doc: 'filter scale: {S/small, M/medium, L/large}'
    inputBinding:
      position: 101
      prefix: --filter-scale
  - id: filter_size
    type:
      - 'null'
      - int
    doc: 'filter size: 1 to 4294967295.'
    inputBinding:
      position: 101
      prefix: --filter-size
  - id: filter_type
    type:
      - 'null'
      - string
    doc: 'filter type (windowing function): {0/rectangular, 1/hamming, 2/hann, 3/blackman,
      4/triangular, 5/welch, 6/sine, 7/nuttall}.'
    inputBinding:
      position: 101
      prefix: --filter-type
  - id: format
    type:
      - 'null'
      - string
    doc: 'format of the output (position) file: {pos, json}.'
    inputBinding:
      position: 101
      prefix: --format
  - id: level
    type:
      - 'null'
      - int
    doc: 'level of compression: 0 to 6.'
    inputBinding:
      position: 101
      prefix: --level
  - id: list_levels
    type:
      - 'null'
      - boolean
    doc: list of compression levels
    inputBinding:
      position: 101
      prefix: --list-levels
  - id: min_segment_size
    type:
      - 'null'
      - int
    doc: 'minimum segment size: 1 to 4294967295.'
    inputBinding:
      position: 101
      prefix: --min-segment-size
  - id: no_self_complexity
    type:
      - 'null'
      - boolean
    doc: 'do not compute self complexity. Default: not used'
    inputBinding:
      position: 101
      prefix: --no-self-complexity
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads: 1 to 255.'
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: reference_begin_guard
    type:
      - 'null'
      - int
    doc: 'reference begin guard: -32768 to 32767.'
    inputBinding:
      position: 101
      prefix: --reference-begin-guard
  - id: reference_end_guard
    type:
      - 'null'
      - int
    doc: 'reference ending guard: -32768 to 32767.'
    inputBinding:
      position: 101
      prefix: --reference-end-guard
  - id: reference_file
    type: File
    doc: reference file (Seq/FASTA/FASTQ)
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_model
    type:
      - 'null'
      - string
    doc: "parameters of models\n                <INT>   [3mk [0m:  context size\n\
      \                <INT>   [3mw [0m:  width of sketch in log2 form,\n        \
      \                   e.g., set 10 for w=2^10=1024\n                <INT>   [3md
      [0m:  depth of sketch\n                <INT>   [3mir [0m: inverted repeat: {0,
      1, 2}\n                           0: regular (not inverted)\n              \
      \             1: inverted, solely\n                           2: both regular
      and inverted\n              <FLOAT>   [3ma [0m:  estimator\n              <FLOAT>\
      \   [3mg [0m:  forgetting factor: 0.0 to 1.0\n                <INT>   [3mt [0m:\
      \  threshold (number of substitutions)"
    inputBinding:
      position: 101
      prefix: --reference-model
  - id: sampling_step
    type:
      - 'null'
      - int
    doc: sampling step.
    inputBinding:
      position: 101
      prefix: --sampling-step
  - id: save_filtered
    type:
      - 'null'
      - boolean
    doc: 'save filtered file (*.fil). Default: not used'
    inputBinding:
      position: 101
      prefix: --save-filtered
  - id: save_profile
    type:
      - 'null'
      - boolean
    doc: 'save profile (*.prf). Default: not used'
    inputBinding:
      position: 101
      prefix: --save-profile
  - id: save_profile_filtered_segmented
    type:
      - 'null'
      - boolean
    doc: "save profile, filetered and segmented files.\n            Default: not used"
    inputBinding:
      position: 101
      prefix: --save-profile-filtered-segmented
  - id: save_segmented
    type:
      - 'null'
      - boolean
    doc: 'save segmented files (*.s[i]). Default: not used'
    inputBinding:
      position: 101
      prefix: --save-segmented
  - id: save_sequence
    type:
      - 'null'
      - boolean
    doc: 'save sequence (input: FASTA/FASTQ). Default: not used'
    inputBinding:
      position: 101
      prefix: --save-sequence
  - id: tar_file
    type: File
    doc: target file    (Seq/FASTA/FASTQ)
    inputBinding:
      position: 101
      prefix: --target
  - id: target_begin_guard
    type:
      - 'null'
      - int
    doc: 'target begin guard: -32768 to 32767.'
    inputBinding:
      position: 101
      prefix: --target-begin-guard
  - id: target_end_guard
    type:
      - 'null'
      - int
    doc: 'target ending guard: -32768 to 32767.'
    inputBinding:
      position: 101
      prefix: --target-end-guard
  - id: target_model
    type:
      - 'null'
      - string
    doc: "parameters of models\n                <INT>   [3mk [0m:  context size\n\
      \                <INT>   [3mw [0m:  width of sketch in log2 form,\n        \
      \                   e.g., set 10 for w=2^10=1024\n                <INT>   [3md
      [0m:  depth of sketch\n                <INT>   [3mir [0m: inverted repeat: {0,
      1, 2}\n                           0: regular (not inverted)\n              \
      \             1: inverted, solely\n                           2: both regular
      and inverted\n              <FLOAT>   [3ma [0m:  estimator\n              <FLOAT>\
      \   [3mg [0m:  forgetting factor: 0.0 to 1.0\n                <INT>   [3mt [0m:\
      \  threshold (number of substitutions)"
    inputBinding:
      position: 101
      prefix: --target-model
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'threshold: 0.0 to 20.0.'
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: more information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smashpp:23.09--h9948957_1
stdout: smashpp.out
