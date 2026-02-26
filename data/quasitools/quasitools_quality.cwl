cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - quality
label: quasitools_quality
doc: "Quasitools quality performs quality control on FASTQ reads and outputs the\n\
  \  filtered FASTQ reads in the specified directory.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: forward_reads
    type: File
    doc: Forward FASTQ reads
    inputBinding:
      position: 1
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: Reverse FASTQ reads
    inputBinding:
      position: 2
  - id: filter_ns
    type:
      - 'null'
      - boolean
    doc: "Flag to enable the filtering of n's. This\n                            \
      \    option and --mask_reads cannot be both enabled\n                      \
      \          simultaneously."
    inputBinding:
      position: 103
      prefix: --ns
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: "Reads which fall short of the specified length\n                       \
      \         will be filtered out."
    inputBinding:
      position: 103
      prefix: --length_cutoff
  - id: mask_reads
    type:
      - 'null'
      - boolean
    doc: "Mask low quality regions in reads if below\n                           \
      \     minimum read quality. This option and --ns\n                         \
      \       cannot be both enabled simultaneously."
    inputBinding:
      position: 103
      prefix: --mask_reads
  - id: mean_score
    type:
      - 'null'
      - boolean
    doc: "Use either median score (default) or mean\n                            \
      \    score for the score cutoff value."
    inputBinding:
      position: 103
      prefix: --mean
  - id: median_score
    type:
      - 'null'
      - boolean
    doc: "Use either median score (default) or mean\n                            \
      \    score for the score cutoff value."
    inputBinding:
      position: 103
      prefix: --median
  - id: min_read_qual
    type:
      - 'null'
      - int
    doc: "Minimum quality for positions in read if\n                             \
      \   masking is enabled."
    inputBinding:
      position: 103
      prefix: --min_read_qual
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 103
      prefix: --output_dir
  - id: score_cutoff
    type:
      - 'null'
      - int
    doc: "Reads that have a median or mean quality score\n                       \
      \         (depending on the score type specified) less\n                   \
      \             than the score cutoff value will be filtered\n               \
      \                 out."
    inputBinding:
      position: 103
      prefix: --score_cutoff
  - id: trim_reads
    type:
      - 'null'
      - boolean
    doc: "Iteratively trim reads based on filter values\n                        \
      \        if enabled. Remove reads which do not meet\n                      \
      \          filter values if disabled."
    inputBinding:
      position: 103
      prefix: --trim_reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
stdout: quasitools_quality.out
