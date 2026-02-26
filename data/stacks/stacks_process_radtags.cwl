cwlVersion: v1.2
class: CommandLineTool
baseCommand: process_radtags
label: stacks_process_radtags
doc: "Process RAD-seq data to demultiplex, clean, and filter reads.\n\nTool homepage:
  https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: adapter_1_sequence
    type:
      - 'null'
      - string
    doc: Provide adaptor sequence that may occur on the single-end read for 
      filtering.
    inputBinding:
      position: 101
      prefix: --adapter-1
  - id: adapter_2_sequence
    type:
      - 'null'
      - string
    doc: Provide adaptor sequence that may occur on the paired-read for 
      filtering.
    inputBinding:
      position: 101
      prefix: --adapter-2
  - id: adapter_mismatches
    type:
      - 'null'
      - int
    doc: Number of mismatches allowed in the adapter sequence.
    inputBinding:
      position: 101
      prefix: --adapter-mm
  - id: barcode_dist_1
    type:
      - 'null'
      - int
    doc: The number of allowed mismatches when rescuing single-end barcodes.
    default: 1
    inputBinding:
      position: 101
      prefix: --barcode-dist-1
  - id: barcode_dist_2
    type:
      - 'null'
      - int
    doc: The number of allowed mismatches when rescuing paired-end barcodes 
      (defaults to --barcode-dist-1).
    inputBinding:
      position: 101
      prefix: --barcode-dist-2
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: Path to a file containing barcodes for this run, omit to ignore any 
      barcoding or for already demultiplexed data.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: bestrad_protocol
    type:
      - 'null'
      - boolean
    doc: Library was generated using BestRAD, check for restriction enzyme on 
      either read and potentially transpose reads.
    inputBinding:
      position: 101
      prefix: --bestrad
  - id: clean_data
    type:
      - 'null'
      - boolean
    doc: Clean data, remove any read with an uncalled base ('N').
    inputBinding:
      position: 101
      prefix: --clean
  - id: disable_poly_g_check
    type:
      - 'null'
      - boolean
    doc: 'Disable checking for runs of poly-Gs (default: autodetect based on machine
      type in FASTQ header).'
    inputBinding:
      position: 101
      prefix: --disable-poly-g-check
  - id: disable_rad_cut_site_check
    type:
      - 'null'
      - boolean
    doc: Disable checking if the RAD cut site is intact.
    inputBinding:
      position: 101
      prefix: --disable-rad-check
  - id: discard_low_quality
    type:
      - 'null'
      - boolean
    doc: Discard reads with low quality (phred) scores.
    inputBinding:
      position: 101
      prefix: --quality
  - id: filter_illumina_chastity
    type:
      - 'null'
      - boolean
    doc: Discard reads that have been marked by Illumina's chastity/purity 
      filter as failing.
    inputBinding:
      position: 101
      prefix: --filter-illumina
  - id: force_poly_g_check
    type:
      - 'null'
      - boolean
    doc: 'Force a check for runs of poly-Gs (default: autodetect based on machine
      type in FASTQ header).'
    inputBinding:
      position: 101
      prefix: --force-poly-g-check
  - id: index_index_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode is provided in FASTQ header (Illumina i5 and i7 reads).
    inputBinding:
      position: 101
      prefix: --index-index
  - id: index_inline_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode occurs in FASTQ header (Illumina i5 or i7 read) and is inline 
      with single-end sequence (for single-end data) on paired-end read (for 
      paired-end data).
    inputBinding:
      position: 101
      prefix: --index-inline
  - id: index_null_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode is provided in FASTQ header (Illumina i5 or i7 read).
    inputBinding:
      position: 101
      prefix: --index-null
  - id: inline_index_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode is inline with sequence on single-end read and occurs in FASTQ 
      header (from either i5 or i7 read).
    inputBinding:
      position: 101
      prefix: --inline-index
  - id: inline_inline_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode is inline with sequence, occurs on single and paired-end read.
    inputBinding:
      position: 101
      prefix: --inline-inline
  - id: inline_null_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode is inline with sequence, occurs only on single-end read 
      (default).
    inputBinding:
      position: 101
      prefix: --inline-null
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Path to a directory of input files.
    inputBinding:
      position: 101
      prefix: --in-path
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to the input file if processing single-end sequences.
    inputBinding:
      position: 101
      prefix: -f
  - id: input_type
    type:
      - 'null'
      - string
    doc: "Input file type, either 'fastq', 'gzfastq' (gzipped fastq), 'bam', or 'bustard'
      (default: guess, or gzfastq if unable to)."
    inputBinding:
      position: 101
      prefix: --in-type
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: Specify that the paired-end reads are interleaved in single files.
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: merge_files
    type:
      - 'null'
      - boolean
    doc: If no barcodes are specified, merge all input files into a single 
      output file.
    inputBinding:
      position: 101
      prefix: --merge
  - id: methylrad_protocol
    type:
      - 'null'
      - boolean
    doc: Library was generated using enzymatic methyl-seq (EM-seq) or bisulphite
      sequencing.
    inputBinding:
      position: 101
      prefix: --methylrad
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: Specify a minimum sequence length (useful if your data has already been
      trimmed).
    inputBinding:
      position: 101
      prefix: --len-limit
  - id: null_index_barcode
    type:
      - 'null'
      - boolean
    doc: Barcode is provided in FASTQ header (Illumina i7 read if both i5 and i7
      read are provided).
    inputBinding:
      position: 101
      prefix: --null-index
  - id: output_basename
    type:
      - 'null'
      - string
    doc: Specify the prefix of the output files when using -f or -1/-2.
    inputBinding:
      position: 101
      prefix: --basename
  - id: output_type
    type:
      - 'null'
      - string
    doc: "Output type, either 'fastq', 'gzfastq', 'fasta', or 'gzfasta' (default:
      match input type)."
    inputBinding:
      position: 101
      prefix: --out-type
  - id: pair_1
    type:
      - 'null'
      - File
    doc: First input file in a set of paired-end sequences.
    inputBinding:
      position: 101
      prefix: '-1'
  - id: pair_2
    type:
      - 'null'
      - File
    doc: Second input file in a set of paired-end sequences.
    inputBinding:
      position: 101
      prefix: '-2'
  - id: paired_input
    type:
      - 'null'
      - boolean
    doc: Files contained within the directory are paired.
    inputBinding:
      position: 101
      prefix: --paired
  - id: quality_encoding
    type:
      - 'null'
      - string
    doc: Specify how quality scores are encoded, 'phred33' (Illumina 
      1.8+/Sanger, default) or 'phred64' (Illumina 1.3-1.5).
    inputBinding:
      position: 101
      prefix: --encoding
  - id: rescue_barcodes
    type:
      - 'null'
      - boolean
    doc: Rescue barcodes and RAD-Tag cut sites.
    inputBinding:
      position: 101
      prefix: --rescue
  - id: restriction_enzyme_1
    type:
      - 'null'
      - string
    doc: Provide the restriction enzyme used (cut site occurs on single-end 
      read).
    inputBinding:
      position: 101
      prefix: --renz-1
  - id: restriction_enzyme_2
    type:
      - 'null'
      - string
    doc: If a double digest was used, provide the second restriction enzyme used
      (cut site occurs on the paired-end read).
    inputBinding:
      position: 101
      prefix: --renz-2
  - id: retain_header
    type:
      - 'null'
      - boolean
    doc: Retain unmodified FASTQ headers in the output.
    inputBinding:
      position: 101
      prefix: --retain-header
  - id: score_limit
    type:
      - 'null'
      - int
    doc: Set the phred score limit. If the average score within the sliding 
      window drops below this value, the read is discarded.
    default: 10
    inputBinding:
      position: 101
      prefix: --score-limit
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run.
    inputBinding:
      position: 101
      prefix: --threads
  - id: truncate_length
    type:
      - 'null'
      - int
    doc: Truncate final read length to this value.
    inputBinding:
      position: 101
      prefix: --truncate
  - id: window_size
    type:
      - 'null'
      - float
    doc: Set the size of the sliding window as a fraction of the read length, 
      between 0 and 1.
    default: 0.15
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to output the processed files.
    outputBinding:
      glob: $(inputs.output_directory)
  - id: discarded_reads_file
    type:
      - 'null'
      - File
    doc: Capture discarded reads to a file.
    outputBinding:
      glob: $(inputs.discarded_reads_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
