cwlVersion: v1.2
class: CommandLineTool
baseCommand: flash
label: flash2
doc: "FLASH (Fast Length Adjustment of SHort reads) is an accurate and fast tool to
  merge paired-end reads that were generated from DNA fragments whose lengths are
  shorter than twice the length of reads.\n\nTool homepage: https://github.com/dstreett/FLASH2"
inputs:
  - id: mates_1
    type:
      - 'null'
      - File
    doc: First mate FASTQ file (or interleaved/tab-delimited file if flags are set)
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
    doc: Compress the output files directly with zlib (gzip format).
    inputBinding:
      position: 103
      prefix: --compress
  - id: compress_prog
    type:
      - 'null'
      - string
    doc: Pipe the output through the compression program PROG (e.g., gzip, bzip2).
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
    inputBinding:
      position: 103
      prefix: --fragment-len
  - id: fragment_len_stddev
    type:
      - 'null'
      - int
    doc: Average fragment standard deviation.
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
    doc: Allow a single file that has the paired-end reads interleaved.
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
    inputBinding:
      position: 103
      prefix: --max-mismatch-density
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap length expected in approximately 90% of read pairs.
    inputBinding:
      position: 103
      prefix: --max-overlap
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: The minimum required overlap length between two reads to provide a confident
      overlap.
    inputBinding:
      position: 103
      prefix: --min-overlap
  - id: min_overlap_outie
    type:
      - 'null'
      - int
    doc: The minimum required overlap length between two reads to provide a confident
      overlap in an outie scenario.
    inputBinding:
      position: 103
      prefix: --min-overlap-outie
  - id: no_discard
    type:
      - 'null'
      - boolean
    doc: This turns off the discard logic
    inputBinding:
      position: 103
      prefix: --no-discard
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files.
    inputBinding:
      position: 103
      prefix: --output-prefix
  - id: percent_cutoff
    type:
      - 'null'
      - int
    doc: The cutoff percentage for each read that will be discarded if it falls below
      -Q option. (0-100)
    inputBinding:
      position: 103
      prefix: --percent-cutoff
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: The smallest ASCII value of the characters used to represent quality values
      of bases in FASTQ files (33 or 64).
    inputBinding:
      position: 103
      prefix: --phred-offset
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: The cut off number for the quality score corresponding with the percent cutoff.
    inputBinding:
      position: 103
      prefix: --quality-cutoff
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
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to directory for output files.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flash2:2.2.00--h577a1d6_9
