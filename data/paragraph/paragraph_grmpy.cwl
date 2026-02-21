cwlVersion: v1.2
class: CommandLineTool
baseCommand: grmpy
label: paragraph_grmpy
doc: "Graph-based read mapping and genotyping for structural variants.\n\nTool homepage:
  https://github.com/Illumina/paragraph"
inputs:
  - id: bad_align_frac
    type:
      - 'null'
      - float
    doc: Fraction of read that needs to be mapped in order for it to be used.
    default: 0.800000012
    inputBinding:
      position: 101
      prefix: --bad-align-frac
  - id: bad_align_uniq_kmer_len
    type:
      - 'null'
      - int
    doc: Kmer length for uniqueness check during read filtering.
    default: 0
    inputBinding:
      position: 101
      prefix: --bad-align-uniq-kmer-len
  - id: genotyping_parameters
    type:
      - 'null'
      - File
    doc: JSON file with genotyping model parameters
    inputBinding:
      position: 101
      prefix: --genotyping-parameters
  - id: graph_sequence_matching
    type:
      - 'null'
      - int
    doc: Enables smith waterman graph alignment
    default: 1
    inputBinding:
      position: 101
      prefix: --graph-sequence-matching
  - id: graphs
    type:
      type: array
      items: File
    doc: JSON file(s) describing the graph(s)
    inputBinding:
      position: 101
      prefix: --graph-spec
  - id: gzip_output
    type:
      - 'null'
      - int
    doc: gzip-compress output files. If -O is used, output file names are appended
      with .gz
    default: 0
    inputBinding:
      position: 101
      prefix: --gzip-output
  - id: infer_read_haplotypes
    type:
      - 'null'
      - int
    doc: Infer haplotype paths using read and fragment information.
    default: 0
    inputBinding:
      position: 101
      prefix: --infer-read-haplotypes
  - id: klib_sequence_matching
    type:
      - 'null'
      - int
    doc: Use klib smith-waterman aligner.
    default: 0
    inputBinding:
      position: 101
      prefix: --klib-sequence-matching
  - id: kmer_sequence_matching
    type:
      - 'null'
      - int
    doc: Use kmer aligner.
    default: 0
    inputBinding:
      position: 101
      prefix: --kmer_sequence_matching
  - id: log_async
    type:
      - 'null'
      - int
    doc: Enable / disable async logging.
    default: 0
    inputBinding:
      position: 101
      prefix: --log-async
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file instead of stderr.
    inputBinding:
      position: 101
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set log level (error, warning, info).
    default: info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: manifest
    type: File
    doc: Manifest of samples with path and bam stats.
    inputBinding:
      position: 101
      prefix: --manifest
  - id: max_reads_per_event
    type:
      - 'null'
      - int
    doc: Maximum number of reads to process for a single event.
    default: 10000
    inputBinding:
      position: 101
      prefix: --max-reads-per-event
  - id: path_sequence_matching
    type:
      - 'null'
      - int
    doc: Enables alignment to paths
    default: 0
    inputBinding:
      position: 101
      prefix: --path-sequence-matching
  - id: progress
    type:
      - 'null'
      - int
    doc: Enable/disable progress reporting
    default: 1
    inputBinding:
      position: 101
      prefix: --progress
  - id: reference
    type: File
    doc: Reference genome fasta file.
    inputBinding:
      position: 101
      prefix: --reference
  - id: response_file
    type:
      - 'null'
      - File
    doc: file with more command line arguments
    inputBinding:
      position: 101
      prefix: --response-file
  - id: sample_threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel sample processing.
    default: 40
    inputBinding:
      position: 101
      prefix: --sample-threads
outputs:
  - id: alignment_output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder for alignments. Note these can become very large and are only
      required for curation / visualisation or faster reanalysis.
    outputBinding:
      glob: $(inputs.alignment_output_folder)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. Will output to stdout if omitted or '-'.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder path. paragraph will attempt to create the folder but not the
      entire path.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
