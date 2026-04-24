cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - aln
label: bwa_aln
doc: "Find the SA coordinates of the input reads\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: prefix
    type: string
    doc: Prefix of the BWA index
    inputBinding:
      position: 1
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 2
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: the input read file is in the BAM format
    inputBinding:
      position: 103
      prefix: -b
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: length of barcode
    inputBinding:
      position: 103
      prefix: -B
  - id: filter_casava
    type:
      - 'null'
      - boolean
    doc: filter Casava-filtered sequences
    inputBinding:
      position: 103
      prefix: -Y
  - id: first_read_in_pair
    type:
      - 'null'
      - boolean
    doc: use the 1st read in a pair (effective with -b)
    inputBinding:
      position: 103
      prefix: '-1'
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 103
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 103
      prefix: -O
  - id: illumina_format
    type:
      - 'null'
      - boolean
    doc: the input is in the Illumina 1.3+ FASTQ-like format
    inputBinding:
      position: 103
      prefix: -I
  - id: indel_end_dist
    type:
      - 'null'
      - int
    doc: do not put an indel within INT bp towards the ends
    inputBinding:
      position: 103
      prefix: -i
  - id: log_gap_penalty
    type:
      - 'null'
      - boolean
    doc: log-scaled gap penalty for long deletions
    inputBinding:
      position: 103
      prefix: -L
  - id: max_del_occ
    type:
      - 'null'
      - int
    doc: maximum occurrences for extending a long deletion
    inputBinding:
      position: 103
      prefix: -d
  - id: max_diff
    type:
      - 'null'
      - float
    doc: 'max #diff (int) or missing prob under 0.02 err rate (float)'
    inputBinding:
      position: 103
      prefix: -n
  - id: max_gap_extensions
    type:
      - 'null'
      - int
    doc: maximum number of gap extensions, -1 for disabling long gaps
    inputBinding:
      position: 103
      prefix: -e
  - id: max_gap_opens
    type:
      - 'null'
      - int
    doc: maximum number or fraction of gap opens
    inputBinding:
      position: 103
      prefix: -o
  - id: max_queue_entries
    type:
      - 'null'
      - int
    doc: maximum entries in the queue
    inputBinding:
      position: 103
      prefix: -m
  - id: max_seed_diff
    type:
      - 'null'
      - int
    doc: maximum differences in the seed
    inputBinding:
      position: 103
      prefix: -k
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    inputBinding:
      position: 103
      prefix: -M
  - id: non_iterative_mode
    type:
      - 'null'
      - boolean
    doc: 'non-iterative mode: search for all n-difference hits (slooow)'
    inputBinding:
      position: 103
      prefix: -N
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: quality threshold for read trimming down to 35bp
    inputBinding:
      position: 103
      prefix: -q
  - id: second_read_in_pair
    type:
      - 'null'
      - boolean
    doc: use the 2nd read in a pair (effective with -b)
    inputBinding:
      position: 103
      prefix: '-2'
  - id: seed_length
    type:
      - 'null'
      - int
    doc: seed length
    inputBinding:
      position: 103
      prefix: -l
  - id: single_end_only
    type:
      - 'null'
      - boolean
    doc: use single-end reads only (effective with -b)
    inputBinding:
      position: 103
      prefix: '-0'
  - id: stop_search_threshold
    type:
      - 'null'
      - int
    doc: stop searching when there are >INT equally best hits
    inputBinding:
      position: 103
      prefix: -R
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: file to write output to instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
