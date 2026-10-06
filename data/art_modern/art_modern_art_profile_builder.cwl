cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_profile_builder
label: art_modern_art_profile_builder
doc: "Build an ART read quality profile from FASTQ/SAM/BAM reads.\n\nTool homepage:\
  \ https://github.com/YU-Zhejian/art_modern"
inputs:
  - id: i_file
    type: File
    doc: the filename of the input FASTQ/SAM/BAM file.
    inputBinding:
      position: 1
      prefix: --i-file
  - id: read_len
    type:
      - 'null'
      - int
    doc: maximum read length to be learnt. If the file mode is PE or MP, will use
      this value on both reads. Cannot be specified together with read_len_1 or read_len_2
    inputBinding:
      position: 1
      prefix: --read_len
  - id: read_len_1
    type:
      - 'null'
      - int
    doc: read length of read 1 to be learnt
    inputBinding:
      position: 1
      prefix: --read_len_1
  - id: read_len_2
    type:
      - 'null'
      - int
    doc: read length of read 2 to be learnt
    inputBinding:
      position: 1
      prefix: --read_len_2
  - id: is_pe
    type:
      - 'null'
      - boolean
    doc: 'Whether the input is paired-end. Default: single-end.'
    inputBinding:
      position: 1
      prefix: --is_pe
  - id: old_behavior
    type:
      - 'null'
      - boolean
    doc: Simulate the behaviour of original ART profile builder. If set, all qualities
      will be offsetted by 1.
    inputBinding:
      position: 1
      prefix: --old_behavior
  - id: o_file1
    type:
      - 'null'
      - string
    doc: Output file name for read 1 profile.
    inputBinding:
      position: 1
      prefix: --o-file1
  - id: o_file2
    type:
      - 'null'
      - string
    doc: Output file name for read 2 profile.
    inputBinding:
      position: 1
      prefix: --o-file2
  - id: i_format
    type:
      - 'null'
      - string
    doc: 'Input file format. AUTO to auto-detect. Valid values: AUTO, FASTQ, SAM,
      BAM, CRAM. (default: AUTO)'
    inputBinding:
      position: 1
      prefix: --i-format
  - id: first_n_reads
    type:
      - 'null'
      - long
    doc: 'Only process the first N reads in the input file. Default: all reads. (default:
      9223372036854775807)'
    inputBinding:
      position: 1
      prefix: --first_n_reads
  - id: parallel
    type:
      - 'null'
      - int
    doc: 'Parallel level. -1 for disable, 0 for all CPUs, >=1 to specify number of
      threads. (default: 0)'
    inputBinding:
      position: 1
      prefix: --parallel
  - id: i_num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads to use for I/O. Note that every thread specified in parallel
      will create i-num_threads threads for I/O. (default: 4)'
    inputBinding:
      position: 1
      prefix: --i-num_threads
  - id: queue_size
    type:
      - 'null'
      - int
    doc: '# reads of the lock-free queue used in reading input HTS files. (default:
      1024)'
    inputBinding:
      position: 1
      prefix: --queue_size
  - id: batch_size
    type:
      - 'null'
      - int
    doc: '# reads of the batches in lock-free queue used in reading input HTS files.
      (default: 1024)'
    inputBinding:
      position: 1
      prefix: --batch_size
  - id: report_size
    type:
      - 'null'
      - long
    doc: '# reads to process before reporting in each worker thread. (default: 1048576)'
    inputBinding:
      position: 1
      prefix: --report_size
outputs:
  - id: profile_1
    type:
      - 'null'
      - File
    doc: Read 1 quality profile.
    outputBinding:
      glob: $(inputs.o_file1)
  - id: profile_2
    type:
      - 'null'
      - File
    doc: Read 2 quality profile.
    outputBinding:
      glob: $(inputs.o_file2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art_modern:1.5.1--hc80e578_0
