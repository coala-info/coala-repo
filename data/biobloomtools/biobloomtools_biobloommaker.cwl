cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobloommaker
label: biobloomtools_biobloommaker
doc: "Creates a bf and txt file from a list of fasta files. The input sequences are
  cut into a k-mers with a sliding window and their hash signatures are inserted into
  a bloom filter.\n\nTool homepage: https://github.com/bcgsc/biobloom"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta or fastq files
    inputBinding:
      position: 1
  - id: bait_score
    type:
      - 'null'
      - string
    doc: Score threshold when considering only bait.
    inputBinding:
      position: 102
      prefix: --baitScore
  - id: fal_pos_rate
    type:
      - 'null'
      - float
    doc: Maximum false positive rate to use in filter.
    default: 0.0075
    inputBinding:
      position: 102
      prefix: --fal_pos_rate
  - id: file_list
    type:
      - 'null'
      - File
    doc: A file of list of file pairs to run in parallel.
    inputBinding:
      position: 102
      prefix: --file_list
  - id: file_prefix
    type: string
    doc: Filter prefix and filter ID. Required option.
    inputBinding:
      position: 102
      prefix: --file_prefix
  - id: hash_num
    type:
      - 'null'
      - int
    doc: Set number of hash functions to use in filter instead of automatically using
      calculated optimal number of functions.
    inputBinding:
      position: 102
      prefix: --hash_num
  - id: inclusive
    type:
      - 'null'
      - boolean
    doc: If one paired read matches, both reads will be included in the filter. Only
      active with the (-r) option.
    inputBinding:
      position: 102
      prefix: --inclusive
  - id: interval
    type:
      - 'null'
      - int
    doc: the interval to report file processing status
    default: 10000000
    inputBinding:
      position: 102
      prefix: --interval
  - id: iterations
    type:
      - 'null'
      - int
    doc: Pass through files N times if threshold is not met.
    inputBinding:
      position: 102
      prefix: --iterations
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size to use to create filter.
    default: 25
    inputBinding:
      position: 102
      prefix: --kmer_size
  - id: no_rep_kmer
    type:
      - 'null'
      - boolean
    doc: Remove all repeat k-mers from the resulting filter in progressive mode.
    inputBinding:
      position: 102
      prefix: --no_rep_kmer
  - id: num_ele
    type:
      - 'null'
      - int
    doc: Set the number of expected elements. If set to 0 number is determined from
      sequences sizes within files.
    default: 0
    inputBinding:
      position: 102
      prefix: --num_ele
  - id: print_reads
    type:
      - 'null'
      - boolean
    doc: During progressive filter creation, print tagged reads to STDOUT in FASTQ
      format for debugging
    inputBinding:
      position: 102
      prefix: --print_reads
  - id: progressive
    type:
      - 'null'
      - float
    doc: Progressive filter creation. The score threshold is specified by N, which
      may be either a floating point score between 0 and 1 or a positive integer.
    inputBinding:
      position: 102
      prefix: --progressive
  - id: streak
    type:
      - 'null'
      - int
    doc: The number of hits tiling in second pass needed to jump Several tiles upon
      a miss. Progressive mode only.
    default: 3
    inputBinding:
      position: 102
      prefix: --streak
  - id: subtract
    type:
      - 'null'
      - File
    doc: Path to filter that you want to uses to minimize repeat propagation of k-mers
      inserted into new filter.
    inputBinding:
      position: 102
      prefix: --subtract
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output location of the filter and filter info files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobloomtools:2.3.5--h077b44d_6
