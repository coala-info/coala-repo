cwlVersion: v1.2
class: CommandLineTool
baseCommand: SeqPurge
label: ngs-bits_SeqPurge
doc: "Removes adapter sequences from paired-end sequencing data.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: adapter_forward
    type:
      - 'null'
      - string
    doc: Forward adapter sequence (at least 15 bases).
    default: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
    inputBinding:
      position: 101
      prefix: -a1
  - id: adapter_reverse
    type:
      - 'null'
      - string
    doc: Reverse adapter sequence (at least 15 bases).
    default: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
    inputBinding:
      position: 101
      prefix: -a2
  - id: block_prefetch
    type:
      - 'null'
      - int
    doc: Number of blocks that may be pre-fetched into memory.
    default: 32
    inputBinding:
      position: 101
      prefix: -block_prefetch
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of FASTQ entries processed in one block.
    default: 10000
    inputBinding:
      position: 101
      prefix: -block_size
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Output FASTQ compression level from 1 (fastest) to 9 (best 
      compression).
    default: 1
    inputBinding:
      position: 101
      prefix: -compression_level
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enables debug output (use only with one thread).
    default: false
    inputBinding:
      position: 101
      prefix: -debug
  - id: enable_error_correction
    type:
      - 'null'
      - boolean
    doc: Enable error-correction of adapter-trimmed reads (only those with 
      insert match).
    default: false
    inputBinding:
      position: 101
      prefix: -ec
  - id: input_forward
    type:
      type: array
      items: File
    doc: Forward input gzipped FASTQ file(s).
    inputBinding:
      position: 101
      prefix: -in1
  - id: input_reverse
    type:
      type: array
      items: File
    doc: Reverse input gzipped FASTQ file(s).
    inputBinding:
      position: 101
      prefix: -in2
  - id: match_percentage
    type:
      - 'null'
      - float
    doc: Minimum percentage of matching bases for sequence/adapter matches.
    default: '80'
    inputBinding:
      position: 101
      prefix: -match_perc
  - id: max_error_probability
    type:
      - 'null'
      - float
    doc: Maximum error probability of insert and adapter matches.
    default: '1e-06'
    inputBinding:
      position: 101
      prefix: -mep
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length after adapter trimming. Shorter reads are 
      discarded.
    default: 30
    inputBinding:
      position: 101
      prefix: -min_len
  - id: n_trim_count
    type:
      - 'null'
      - int
    doc: Number of subsequent Ns to trimmed using a sliding window approach from
      the front of reads. Set to 0 to disable.
    default: 7
    inputBinding:
      position: 101
      prefix: -ncut
  - id: output_singletons_prefix
    type:
      - 'null'
      - string
    doc: Name prefix of singleton read output files (if only one read of a pair 
      is discarded).
    default: ''
    inputBinding:
      position: 101
      prefix: -out3
  - id: progress_interval
    type:
      - 'null'
      - int
    doc: Enables progress output at the given interval in milliseconds (disabled
      by default).
    default: -1
    inputBinding:
      position: 101
      prefix: -progress
  - id: qc_file
    type:
      - 'null'
      - File
    doc: If set, a read QC file in qcML format is created (just like ReadQC).
    default: ''
    inputBinding:
      position: 101
      prefix: -qc
  - id: quality_trim_cutoff
    type:
      - 'null'
      - int
    doc: Quality trimming cutoff for trimming from the end of reads using a 
      sliding window approach. Set to 0 to disable.
    default: 15
    inputBinding:
      position: 101
      prefix: -qcut
  - id: quality_trim_offset
    type:
      - 'null'
      - int
    doc: Quality trimming FASTQ score offset.
    default: 33
    inputBinding:
      position: 101
      prefix: -qoff
  - id: quality_trim_window
    type:
      - 'null'
      - int
    doc: Quality trimming window size.
    default: 5
    inputBinding:
      position: 101
      prefix: -qwin
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: summary_file
    type:
      - 'null'
      - File
    doc: Write summary/progress to this file instead of STDOUT.
    default: ''
    inputBinding:
      position: 101
      prefix: -summary
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads used for trimming (up to three additional threads
      are used for reading and writing).
    default: 1
    inputBinding:
      position: 101
      prefix: -threads
  - id: tool_definition_xml
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
outputs:
  - id: output_forward
    type: File
    doc: Forward output gzipped FASTQ file.
    outputBinding:
      glob: $(inputs.output_forward)
  - id: output_reverse
    type: File
    doc: Reverse output gzipped FASTQ file.
    outputBinding:
      glob: $(inputs.output_reverse)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
