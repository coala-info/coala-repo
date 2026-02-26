cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdeval
label: rdeval
doc: "Evaluates sequencing reads.\n\nTool homepage: https://github.com/vgl-hub/rdeval"
inputs:
  - id: input_file
    type: File
    doc: Input file (fa*[.gz], bam, cram, rd)
    inputBinding:
      position: 1
  - id: expected_genome_size
    type:
      - 'null'
      - int
    doc: Expected genome size as uint
    inputBinding:
      position: 2
  - id: cifi_enzyme
    type:
      - 'null'
      - string
    doc: the specific enzyme to use for SciFi read digestion.
    inputBinding:
      position: 103
      prefix: --cifi-enzyme
  - id: cifi_out_combinations
    type:
      - 'null'
      - boolean
    doc: 'output all per-read combinations of SciFi fragments (default: no).'
    inputBinding:
      position: 103
      prefix: --cifi-out-combinations
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: numbers of compression threads used by htslib for bam/cram (default:6).
    default: 6
    inputBinding:
      position: 103
      prefix: --compression-threads
  - id: decompression_threads
    type:
      - 'null'
      - int
    doc: numbers of decompression threads used by htslib for bam/cram 
      (default:4).
    default: 4
    inputBinding:
      position: 103
      prefix: --decompression-threads
  - id: exclude_list
    type:
      - 'null'
      - File
    doc: generates output on a excluding list of headers.
    inputBinding:
      position: 103
      prefix: --exclude-list
  - id: filter
    type:
      - 'null'
      - string
    doc: "filter reads using <exp> in quotes, e.g. 'l>10' for longer than 10bp or
      'l>10 & q>10' to further exclude reads by quality (default: none)."
    inputBinding:
      position: 103
      prefix: --filter
  - id: homopolymer_compress
    type:
      - 'null'
      - int
    doc: compress all the homopolymers longer than n in the input.
    inputBinding:
      position: 103
      prefix: --homopolymer-compress
  - id: include_list
    type:
      - 'null'
      - File
    doc: generates output on a subset list of headers.
    inputBinding:
      position: 103
      prefix: --include-list
  - id: input_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: input file (fa*[.gz], bam, cram, rd).
    inputBinding:
      position: 103
      prefix: --input-reads
  - id: max_memory
    type:
      - 'null'
      - int
    doc: max number of bases in a single buffer of the ring buffer 
      (default:1000000 bp or ~1MB). The total number of buffers is approximately
      consumer threads*2.
    default: 1000000
    inputBinding:
      position: 103
      prefix: --max-memory
  - id: md5
    type:
      - 'null'
      - boolean
    doc: print md5 of .rd files.
    inputBinding:
      position: 103
      prefix: --md5
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: a prefix for the names of the files when generating multiple outputs. 
      Inputs names will be used for each file.
    inputBinding:
      position: 103
      prefix: --out-prefix
  - id: out_size
    type:
      - 'null'
      - string
    doc: u|s|h|c generates size list (unsorted|sorted|histogram|inverse 
      cumulative table).
    inputBinding:
      position: 103
      prefix: --out-size
  - id: parallel_files
    type:
      - 'null'
      - int
    doc: numbers of files that can be opened and processed in parallel (producer
      threads, default:4).
    default: 4
    inputBinding:
      position: 103
      prefix: --parallel-files
  - id: quality
    type:
      - 'null'
      - string
    doc: q|a generates list of average quality for each read (q) or both length 
      and quality (a).
    inputBinding:
      position: 103
      prefix: --quality
  - id: random_seed
    type:
      - 'null'
      - int
    doc: an optional random seed to make subsampling reproducible.
    inputBinding:
      position: 103
      prefix: --random-seed
  - id: sample
    type:
      - 'null'
      - float
    doc: fraction of reads to subsample.
    inputBinding:
      position: 103
      prefix: --sample
  - id: sequence_report
    type:
      - 'null'
      - boolean
    doc: generates a per-read report
    inputBinding:
      position: 103
      prefix: --sequence-report
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: tabular output.
    inputBinding:
      position: 103
      prefix: --tabular
  - id: threads
    type:
      - 'null'
      - int
    doc: numbers of consumer threads (default:8).
    default: 8
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: output file (fa*[.gz], bam, cram, rd). Optionally write reads to file 
      or generate rd summary file.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdeval:0.0.8--r44h35c04b2_1
