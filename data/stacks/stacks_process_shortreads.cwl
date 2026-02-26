cwlVersion: v1.2
class: CommandLineTool
baseCommand: process_shortreads
label: stacks_process_shortreads
doc: "process_shortreads 2.68\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: adapter_1
    type:
      - 'null'
      - string
    doc: provide adaptor sequence that may occur on the first read for 
      filtering.
    inputBinding:
      position: 101
      prefix: --adapter-1
  - id: adapter_2
    type:
      - 'null'
      - string
    doc: provide adaptor sequence that may occur on the paired-read for 
      filtering.
    inputBinding:
      position: 101
      prefix: --adapter-2
  - id: adapter_mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches allowed in the adapter sequence.
    inputBinding:
      position: 101
      prefix: --adapter-mm
  - id: barcode_distance
    type:
      - 'null'
      - int
    doc: provide the distace between barcodes to allow for barcode rescue 
      (default 2).
    default: 2
    inputBinding:
      position: 101
      prefix: --barcode-dist
  - id: barcode_file
    type: File
    doc: a list of barcodes for this run.
    inputBinding:
      position: 101
      prefix: -b
  - id: capture_discarded
    type:
      - 'null'
      - boolean
    doc: capture discarded reads to a file.
    inputBinding:
      position: 101
      prefix: -D
  - id: clean_data
    type:
      - 'null'
      - boolean
    doc: clean data, remove any read with an uncalled base.
    inputBinding:
      position: 101
      prefix: -c
  - id: discard_low_quality
    type:
      - 'null'
      - boolean
    doc: discard reads with low quality scores.
    inputBinding:
      position: 101
      prefix: -q
  - id: encoding
    type:
      - 'null'
      - string
    doc: specify how quality scores are encoded, 'phred33' (Illumina 
      1.8+/Sanger, default) or 'phred64' (Illumina 1.3-1.5).
    default: phred33
    inputBinding:
      position: 101
      prefix: -E
  - id: filter_illumina_chastity
    type:
      - 'null'
      - boolean
    doc: discard reads that have been marked by Illumina's chastity/purity 
      filter as failing.
    inputBinding:
      position: 101
      prefix: --filter-illumina
  - id: index_index
    type:
      - 'null'
      - boolean
    doc: barcode is provded in FASTQ header (Illumina i5 and i7 reads).
    inputBinding:
      position: 101
  - id: index_inline
    type:
      - 'null'
      - boolean
    doc: barcode occurs in FASTQ header (Illumina i5 or i7 read) and is inline 
      with single-end sequence (for single-end data) on paired-end read (for 
      paired-end data).
    inputBinding:
      position: 101
  - id: index_null
    type:
      - 'null'
      - boolean
    doc: barcode is provded in FASTQ header (Illumina i5 or i7 read).
    inputBinding:
      position: 101
  - id: inline_index
    type:
      - 'null'
      - boolean
    doc: barcode is inline with sequence on single-end read and occurs in FASTQ 
      header (from either i5 or i7 read).
    inputBinding:
      position: 101
  - id: inline_inline
    type:
      - 'null'
      - boolean
    doc: barcode is inline with sequence, occurs on single and paired-end read.
    inputBinding:
      position: 101
  - id: inline_null
    type:
      - 'null'
      - boolean
    doc: barcode is inline with sequence, occurs only on single-end read 
      (default).
    inputBinding:
      position: 101
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: path to a directory of single-end Illumina files.
    inputBinding:
      position: 101
      prefix: -p
  - id: input_file
    type:
      - 'null'
      - File
    doc: path to the input file if processing single-end seqeunces.
    inputBinding:
      position: 101
      prefix: -f
  - id: input_type
    type:
      - 'null'
      - string
    doc: input file type, either 'bustard' for the Illumina BUSTARD format, 
      'bam', 'fastq' (default), or 'gzfastq' for gzipped FASTQ.
    default: fastq
    inputBinding:
      position: 101
      prefix: -i
  - id: is_interleaved_input_dir
    type:
      - 'null'
      - boolean
    doc: specify that the paired-end reads are interleaved in single files.
    inputBinding:
      position: 101
      prefix: -I
  - id: is_paired_input_dir
    type:
      - 'null'
      - boolean
    doc: specify that input is paired (for use with '-p').
    inputBinding:
      position: 101
      prefix: -P
  - id: mate_pair_circularized
    type:
      - 'null'
      - boolean
    doc: raw reads are circularized mate-pair data, first read will be reverse 
      complemented.
    inputBinding:
      position: 101
      prefix: --mate-pair
  - id: merge_files
    type:
      - 'null'
      - boolean
    doc: if no barcodes are specified, merge all input files into a single 
      output file (or single pair of files).
    inputBinding:
      position: 101
      prefix: --merge
  - id: min_len_limit
    type:
      - 'null'
      - int
    doc: when trimming sequences, specify the minimum length a sequence must be 
      to keep it (default 31bp).
    default: 31bp
    inputBinding:
      position: 101
      prefix: --len-limit
  - id: no_overhang
    type:
      - 'null'
      - boolean
    doc: data does not contain an overhang nucleotide between barcode and 
      seqeunce.
    inputBinding:
      position: 101
      prefix: --no-overhang
  - id: no_read_trimming
    type:
      - 'null'
      - boolean
    doc: do not trim low quality reads, just discard them.
    inputBinding:
      position: 101
      prefix: --no-read-trimming
  - id: null_index
    type:
      - 'null'
      - boolean
    doc: barcode is provded in FASTQ header (Illumina i7 read if both i5 and i7 
      read are provided).
    inputBinding:
      position: 101
  - id: output_type
    type:
      - 'null'
      - string
    doc: output type, either 'fastq' or 'fasta' (default gzfastq).
    default: gzfastq
    inputBinding:
      position: 101
      prefix: -y
  - id: pair_1
    type:
      - 'null'
      - File
    doc: first input file in a set of paired-end sequences.
    inputBinding:
      position: 101
      prefix: '-1'
  - id: pair_2
    type:
      - 'null'
      - File
    doc: second input file in a set of paired-end sequences.
    inputBinding:
      position: 101
      prefix: '-2'
  - id: rescue_barcodes
    type:
      - 'null'
      - boolean
    doc: rescue barcodes.
    inputBinding:
      position: 101
      prefix: -r
  - id: retain_header
    type:
      - 'null'
      - boolean
    doc: retain unmodified FASTQ headers in the output.
    inputBinding:
      position: 101
      prefix: --retain-header
  - id: score_limit
    type:
      - 'null'
      - int
    doc: set the score limit. If the average score within the sliding window 
      drops below this value, the read is discarded (default 10).
    default: 10
    inputBinding:
      position: 101
      prefix: -s
  - id: sliding_window_size
    type:
      - 'null'
      - float
    doc: set the size of the sliding window as a fraction of the read length, 
      between 0 and 1 (default 0.15).
    default: 0.15
    inputBinding:
      position: 101
      prefix: -w
  - id: truncate_length
    type:
      - 'null'
      - int
    doc: truncate final read length to this value.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: out_dir
    type: Directory
    doc: path to output the processed files.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
