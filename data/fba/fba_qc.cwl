cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba qc
label: fba_qc
doc: "Generate diagnostic information. If `-1` is omitted, bulk mode is enabled and
  only read 2 will be analyzed.\n\nTool homepage: https://github.com/jlduan/fba"
inputs:
  - id: cb_num_n_threshold
    type:
      - 'null'
      - int
    doc: specify maximum number of ambiguous nucleotides allowed for read 1. The
      default is no limit
    inputBinding:
      position: 101
      prefix: --cb_num_n_threshold
  - id: cell_barcode_mismatches
    type:
      - 'null'
      - int
    doc: specify cell barcode mismatching threshold. Default (3)
    default: 3
    inputBinding:
      position: 101
      prefix: --cb_mismatches
  - id: cell_barcode_reverse_complement
    type:
      - 'null'
      - boolean
    doc: specify to convert cell barcode sequences into their reverse-complement
      counterparts for processing.
    inputBinding:
      position: 101
      prefix: --cell_barcode_reverse_complement
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: specify the chunk size for multiprocessing. Default (50,000)
    default: 50000
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: fb_num_n_threshold
    type:
      - 'null'
      - int
    doc: specify maximum number of ambiguous nucleotides allowed for read 2. The
      default is no limit
    inputBinding:
      position: 101
      prefix: --fb_num_n_threshold
  - id: feature_barcode_mismatches
    type:
      - 'null'
      - int
    doc: specify feature barcode mismatching threshold. Default (3)
    default: 3
    inputBinding:
      position: 101
      prefix: --fb_mismatches
  - id: feature_ref
    type: File
    doc: specify a reference of feature barcodes
    inputBinding:
      position: 101
      prefix: --feature_ref
  - id: num_reads
    type:
      - 'null'
      - int
    doc: specify number of reads for analysis. Set to (None) will analyze all 
      the reads. Default (100,000)
    default: 100000
    inputBinding:
      position: 101
      prefix: --num_reads
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: specify a output directory. Default (./qc)
    default: ./qc
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: read1
    type:
      - 'null'
      - File
    doc: specify fastq file for read 1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read1_coordinate
    type:
      - 'null'
      - string
    doc: "specify coordinate 'start,end' of read 1 to search (doesn't need to be the
      exact expected barcode coordinate). Coordinate is 0-based, half-open. For example,
      '0,16': starts at 0, stops at 15. The default is to use all the nucleotide bases.
      Nucleotide bases outside the range will be masked as lowercase in the output"
    inputBinding:
      position: 101
      prefix: --read1_coordinate
  - id: read2
    type: File
    doc: specify fastq file for read 2. If only read 2 file is provided, bulk 
      mode is enabled (skipping arguments '-w/--whitelist', 
      '-cb_m/--cb_mismatches', '-r1_c/--read1_coordinate', must provide 
      '-r2_c/--read2_coordinate' and '-fb_m/--fb_mismatches'). In bulk mode, 
      read 2 will be searched against reference feature barcodes and read count 
      for each feature barcode will be summarized
    inputBinding:
      position: 101
      prefix: --read2
  - id: read2_coordinate
    type:
      - 'null'
      - string
    doc: see '-r1_c/--read1_coordinate'
    inputBinding:
      position: 101
      prefix: --read2_coordinate
  - id: threads
    type:
      - 'null'
      - int
    doc: specify number of threads for barcode extraction. Default is to use all
      available
    inputBinding:
      position: 101
      prefix: --threads
  - id: whitelist
    type:
      - 'null'
      - File
    doc: specify a whitelist of accepted cell barcodes
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
stdout: fba_qc.out
