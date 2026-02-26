cwlVersion: v1.2
class: CommandLineTool
baseCommand: spring
label: spring
doc: "Exactly one of compress or decompress needs to be specified\n\nTool homepage:
  https://github.com/shubhamchandak94/Spring"
inputs:
  - id: allow_read_reordering
    type:
      - 'null'
      - boolean
    doc: "do not retain read order during compression \n                         \
      \         (paired reads still remain paired)"
    inputBinding:
      position: 101
      prefix: --allow-read-reordering
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress
    inputBinding:
      position: 101
      prefix: --compress
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress
    inputBinding:
      position: 101
      prefix: --decompress
  - id: decompress_range
    type:
      - 'null'
      - type: array
        items: string
    doc: "--decompress-range start end\n                                  (optional)
      decompress only reads (or read \n                                  pairs for
      PE datasets) from start to end \n                                  (both inclusive)
      (1 <= start <= end <= \n                                  num_reads (or num_read_pairs
      for PE)). If -r \n                                  was specified during compression,
      the range \n                                  of reads does not correspond to
      the original \n                                  order of reads in the FASTQ
      file."
    inputBinding:
      position: 101
      prefix: --decompress-range
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: "enable if compression input is fasta file \n                           \
      \       (i.e., no qualities)"
    inputBinding:
      position: 101
      prefix: --fasta-input
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: "gzip level (0-9) to use during decompression \n                        \
      \          if -g flag is specified (default: 6)"
    default: 6
    inputBinding:
      position: 101
      prefix: --gzip-level
  - id: gzipped_fastq
    type:
      - 'null'
      - boolean
    doc: "enable if compression input is gzipped fastq \n                        \
      \          or to output gzipped fastq during \n                            \
      \      decompression"
    inputBinding:
      position: 101
      prefix: --gzipped-fastq
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: input file name (two files for paired end)
    inputBinding:
      position: 101
      prefix: --input-file
  - id: long_read_lengths
    type:
      - 'null'
      - boolean
    doc: "Use for compression of arbitrarily long read \n                        \
      \          lengths. Can also provide better compression \n                 \
      \                 for reads with significant number of indels. \n          \
      \                        -r disabled in this mode. For Illumina short \n   \
      \                               reads, compression is better without -l flag."
    inputBinding:
      position: 101
      prefix: --long
  - id: no_ids
    type:
      - 'null'
      - boolean
    doc: "do not retain read identifiers during \n                               \
      \   compression"
    inputBinding:
      position: 101
      prefix: --no-ids
  - id: no_quality
    type:
      - 'null'
      - boolean
    doc: "do not retain quality values during \n                                 \
      \ compression"
    inputBinding:
      position: 101
      prefix: --no-quality
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads (default 8)
    default: 8
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: quality_opts
    type:
      - 'null'
      - string
    doc: "quality mode: possible modes are\n                                  1. -q
      lossless (default)\n                                  2. -q qvz qv_ratio (QVZ
      lossy compression, \n                                  parameter qv_ratio roughly
      corresponds to \n                                  bits used per quality value)\n\
      \                                  3. -q ill_bin (Illumina 8-level binning)\n\
      \                                  4. -q binary thr high low (binary (2-level)\
      \ \n                                  thresholding, quality binned to high if
      >= \n                                  thr and to low if < thr)"
    inputBinding:
      position: 101
      prefix: --quality-opts
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: "directory to create temporary files (default \n                        \
      \          current directory)"
    default: .
    inputBinding:
      position: 101
      prefix: --working-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "output file name (for paired end \n                                  decompression,
      if only one file is specified, \n                                  two output
      files will be created by suffixing\n                                  .1 and
      .2.)"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spring:1.1.1--h4ac6f70_3
