cwlVersion: v1.2
class: CommandLineTool
baseCommand: paragraph
label: paragraph
doc: "Graph-based structural variant caller and sequence aligner.\n\nTool homepage:
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
  - id: bad_align_nonuniq
    type:
      - 'null'
      - int
    doc: Remove reads that are not mapped uniquely.
    default: 1
    inputBinding:
      position: 101
      prefix: --bad-align-nonuniq
  - id: bad_align_uniq_kmer_len
    type:
      - 'null'
      - int
    doc: Kmer length for uniqueness check during read filtering.
    default: 0
    inputBinding:
      position: 101
      prefix: --bad-align-uniq-kmer-len
  - id: bam
    type:
      type: array
      items: File
    doc: Input BAM file(s) for read extraction. We align all reads to all graphs.
    inputBinding:
      position: 101
      prefix: --bam
  - id: graph_sequence_matching
    type:
      - 'null'
      - int
    doc: Enables smith waterman graph alignment
    default: 1
    inputBinding:
      position: 101
      prefix: --graph-sequence-matching
  - id: graph_spec
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
      prefix: --kmer-sequence-matching
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
  - id: max_reads_per_event
    type:
      - 'null'
      - int
    doc: Maximum number of reads to process for a single event.
    default: 10000
    inputBinding:
      position: 101
      prefix: --max-reads-per-event
  - id: output_alignments
    type:
      - 'null'
      - int
    doc: Output alignments for every read (large).
    default: 0
    inputBinding:
      position: 101
      prefix: --output-alignments
  - id: output_detailed_read_counts
    type:
      - 'null'
      - int
    doc: Output detailed read counts not just for paths but also for each node/edge
      on the paths.
    default: 0
    inputBinding:
      position: 101
      prefix: --output-detailed-read-counts
  - id: output_everything
    type:
      - 'null'
      - int
    doc: Write all information we have into JSON. (=enable all --output-* above)
    default: 0
    inputBinding:
      position: 101
      prefix: --output-everything
  - id: output_filtered_alignments
    type:
      - 'null'
      - int
    doc: Output alignments for every read even when it was filtered (larger).
    default: 0
    inputBinding:
      position: 101
      prefix: --output-filtered-alignments
  - id: output_node_coverage
    type:
      - 'null'
      - int
    doc: Output coverage for nodes
    default: 0
    inputBinding:
      position: 101
      prefix: --output-node-coverage
  - id: output_path_coverage
    type:
      - 'null'
      - int
    doc: Output coverage for paths
    default: 0
    inputBinding:
      position: 101
      prefix: --output-path-coverage
  - id: output_read_haplotypes
    type:
      - 'null'
      - int
    doc: Output graph haplotypes supported by reads.
    default: 0
    inputBinding:
      position: 101
      prefix: --output-read-haplotypes
  - id: output_variants
    type:
      - 'null'
      - int
    doc: Output variants not present in the graph.
    default: 0
    inputBinding:
      position: 101
      prefix: --output-variants
  - id: path_sequence_matching
    type:
      - 'null'
      - int
    doc: Enable path seeding aligner
    default: 1
    inputBinding:
      position: 101
      prefix: --path-sequence-matching
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
  - id: target_regions
    type:
      - 'null'
      - string
    doc: Comma-separated list of target regions, e.g. chr1:1-20,chr2:2-40. This overrides
      the target regions in the graph spec.
    inputBinding:
      position: 101
      prefix: --target-regions
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel alignment.
    default: 40
    inputBinding:
      position: 101
      prefix: --threads
  - id: validate_alignments
    type:
      - 'null'
      - int
    doc: Use information in the input bam read names to collect statistics about the
      accuracy of alignments.
    default: 0
    inputBinding:
      position: 101
      prefix: --validate-alignments
  - id: variant_min_frac
    type:
      - 'null'
      - float
    doc: Minimum fraction of reads required to report a variant.
    default: 0.00999999978
    inputBinding:
      position: 101
      prefix: --variant-min-frac
  - id: variant_min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required to report a variant.
    default: 3
    inputBinding:
      position: 101
      prefix: --variant-min-reads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. Will output to stdout if '-' or neither of output-file
      or output-folder provided.
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
