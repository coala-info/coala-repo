cwlVersion: v1.2
class: CommandLineTool
baseCommand: 2fast2q
label: fast2q_2fast2q
doc: "A tool for counting and extracting sequences from FASTQ files, typically used
  for CRISPR screens.\n\nTool homepage: https://github.com/afombravo/2FAST2Q"
inputs:
  - id: cmd_line_mode
    type:
      - 'null'
      - boolean
    doc: cmd line mode.
    inputBinding:
      position: 101
      prefix: -c
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to be used
    inputBinding:
      position: 101
      prefix: --cp
  - id: downstream_search
    type:
      - 'null'
      - string
    doc: Downstream search sequence. This will return any --l X sequence 
      upwnstream of the input sequence.
    inputBinding:
      position: 101
      prefix: --ds
  - id: feature_length
    type:
      - 'null'
      - int
    doc: The length of the feature in bp. It is only used when not using dual 
      sequence search.
    default: 20
    inputBinding:
      position: 101
      prefix: --l
  - id: file_split_mode
    type:
      - 'null'
      - boolean
    doc: File Split mode. If enabled, multiprocessing will split each file and 
      process it.
    inputBinding:
      position: 101
      prefix: --fs
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: If enabled, keeps all temporary files
    inputBinding:
      position: 101
      prefix: --k
  - id: mismatches
    type:
      - 'null'
      - int
    doc: The number of allowed mismatches per feature. When in extract + Count 
      mode, this parameter is ignored.
    default: 1
    inputBinding:
      position: 101
      prefix: --m
  - id: mismatches_downstream
    type:
      - 'null'
      - int
    doc: Downstream search sequence delimiting search sequence mismatches.
    default: 0
    inputBinding:
      position: 101
      prefix: --msd
  - id: mismatches_upstream
    type:
      - 'null'
      - int
    doc: Upstream search sequence delimiting search sequence mismatches.
    default: 0
    inputBinding:
      position: 101
      prefix: --msu
  - id: output_filename
    type:
      - 'null'
      - string
    doc: Specify an output compiled file name
    default: compiled
    inputBinding:
      position: 101
      prefix: --fn
  - id: phred_downstream
    type:
      - 'null'
      - int
    doc: Minimal Phred-score in the downstream search sequence
    default: 30
    inputBinding:
      position: 101
      prefix: --qsd
  - id: phred_score
    type:
      - 'null'
      - int
    doc: Minimal Phred-score. Reads with nucleotides having < than the indicated
      Phred-score will be discarded.
    default: 30
    inputBinding:
      position: 101
      prefix: --ph
  - id: phred_upstream
    type:
      - 'null'
      - int
    doc: Minimal Phred-score in the upstream search sequence
    default: 30
    inputBinding:
      position: 101
      prefix: --qsu
  - id: progress_bars
    type:
      - 'null'
      - boolean
    doc: Adds progress bars (default is enabled)
    inputBinding:
      position: 101
      prefix: --pb
  - id: running_mode
    type:
      - 'null'
      - string
    doc: Running Mode [Counter (C) / Extractor + Counter (EC)].
    default: C
    inputBinding:
      position: 101
      prefix: --mo
  - id: sequencing_path
    type:
      - 'null'
      - File
    doc: The full path to the directory with the sequencing files OR file.
    inputBinding:
      position: 101
      prefix: --s
  - id: sgrna_file
    type:
      - 'null'
      - File
    doc: The full path to the .csv file with the sgRNAs.
    inputBinding:
      position: 101
      prefix: --g
  - id: start_position
    type:
      - 'null'
      - int
    doc: The start position of the feature within the read. Ignored when using 
      sequence searches with known delimiting sequences.
    default: 0
    inputBinding:
      position: 101
      prefix: --st
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Runs 2FAST2Q in test mode with example data.
    inputBinding:
      position: 101
      prefix: -t
  - id: upstream_search
    type:
      - 'null'
      - string
    doc: Upstream search sequence. This will return any --l X sequence 
      downstream of the input sequence.
    inputBinding:
      position: 101
      prefix: --us
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The full path to the output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast2q:2.8.1--pyh7e72e81_0
