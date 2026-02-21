cwlVersion: v1.2
class: CommandLineTool
baseCommand: flash
label: flash
doc: "FLASH (Fast Length Adjustment of SHort reads) is an accurate and fast tool to
  merge paired-end reads that were generated from DNA fragments whose lengths are
  shorter than twice the length of reads.\n\nTool homepage: https://github.com/Dao-AILab/flash-attention"
inputs:
  - id: mates_1
    type:
      - 'null'
      - File
    doc: First mate FASTQ file
    inputBinding:
      position: 1
  - id: mates_2
    type:
      - 'null'
      - File
    doc: Second mate FASTQ file
    inputBinding:
      position: 2
  - id: allow_outies
    type:
      - 'null'
      - boolean
    doc: Also try combining read pairs in the 'outie' orientation.
    inputBinding:
      position: 103
      prefix: --allow-outies
  - id: cap_mismatch_quals
    type:
      - 'null'
      - boolean
    doc: Cap quality scores assigned at mismatch locations to 2.
    inputBinding:
      position: 103
      prefix: --cap-mismatch-quals
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output files directly with zlib, using the gzip container format.
    inputBinding:
      position: 103
      prefix: --compress
  - id: compress_prog
    type:
      - 'null'
      - string
    doc: Pipe the output through the compression program PROG.
    inputBinding:
      position: 103
      prefix: --compress-prog
  - id: compress_prog_args
    type:
      - 'null'
      - string
    doc: A string of additional arguments that will be passed to the compression program.
    inputBinding:
      position: 103
      prefix: --compress-prog-args
  - id: fragment_len
    type:
      - 'null'
      - int
    doc: Average fragment length.
    default: 180
    inputBinding:
      position: 103
      prefix: --fragment-len
  - id: fragment_len_stddev
    type:
      - 'null'
      - int
    doc: Average fragment standard deviation.
    default: 18
    inputBinding:
      position: 103
      prefix: --fragment-len-stddev
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Equivalent to specifying both --interleaved-input and --interleaved-output.
    inputBinding:
      position: 103
      prefix: --interleaved
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: Allow a single file MATES.FASTQ that has the paired-end reads interleaved.
    inputBinding:
      position: 103
      prefix: --interleaved-input
  - id: interleaved_output
    type:
      - 'null'
      - boolean
    doc: Write the uncombined pairs in interleaved FASTQ format.
    inputBinding:
      position: 103
      prefix: --interleaved-output
  - id: max_mismatch_density
    type:
      - 'null'
      - float
    doc: Maximum allowed ratio between the number of mismatched base pairs and the
      overlap length.
    default: 0.25
    inputBinding:
      position: 103
      prefix: --max-mismatch-density
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap length expected in approximately 90% of read pairs.
    default: 65
    inputBinding:
      position: 103
      prefix: --max-overlap
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: The minimum required overlap length between two reads to provide a confident
      overlap.
    default: 10
    inputBinding:
      position: 103
      prefix: --min-overlap
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: The smallest ASCII value of the characters used to represent quality values
      of bases in FASTQ files (33 or 64).
    default: 33
    inputBinding:
      position: 103
      prefix: --phred-offset
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print informational messages.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: read_len
    type:
      - 'null'
      - int
    doc: Average read length.
    default: 100
    inputBinding:
      position: 103
      prefix: --read-len
  - id: suffix
    type:
      - 'null'
      - string
    doc: Use SUFFIX as the suffix of the output files after '.fastq'.
    inputBinding:
      position: 103
      prefix: --suffix
  - id: tab_delimited_input
    type:
      - 'null'
      - boolean
    doc: Assume the input is in tab-delimited format rather than FASTQ.
    inputBinding:
      position: 103
      prefix: --tab-delimited-input
  - id: tab_delimited_output
    type:
      - 'null'
      - boolean
    doc: Write output in tab-delimited format (not FASTQ).
    inputBinding:
      position: 103
      prefix: --tab-delimited-output
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the number of worker threads.
    inputBinding:
      position: 103
      prefix: --threads
  - id: to_stdout
    type:
      - 'null'
      - boolean
    doc: Write the combined reads to standard output.
    inputBinding:
      position: 103
      prefix: --to-stdout
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of output files.
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to directory for output files.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flash:1.2.11--ha92aebf_2
