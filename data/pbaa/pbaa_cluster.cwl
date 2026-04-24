cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbaa
  - cluster
label: pbaa_cluster
doc: "Run clustering tool for HiFi reads using guide sequences.\n\nTool homepage:
  https://github.com/PacificBiosciences/pbAA"
inputs:
  - id: guide_input
    type: File
    doc: Guide sequence(s) in fasta format indexed with samtools faidx version 1.9
      or greater. A FOFN can be provide for multiple files.
    inputBinding:
      position: 1
  - id: read_input
    type: File
    doc: De-multiplexed HiFi reads in fastq format indexed with samtools fqidx version
      1.9 or greater. A FOFN can be provide for multiple files.
    inputBinding:
      position: 2
  - id: filter
    type:
      - 'null'
      - int
    doc: Variants with coverage lower than filter will be ignored.
    inputBinding:
      position: 103
      prefix: --filter
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations to run k-means.
    inputBinding:
      position: 103
      prefix: --iterations
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_alignments_per_read
    type:
      - 'null'
      - int
    doc: The number of random alignments, for each read, within a guide grouping
    inputBinding:
      position: 103
      prefix: --max-alignments-per-read
  - id: max_amplicon_size
    type:
      - 'null'
      - int
    doc: Upper read length cutoff, longer reads will be skipped.
    inputBinding:
      position: 103
      prefix: --max-amplicon-size
  - id: max_consensus_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to use per cluster consensus.
    inputBinding:
      position: 103
      prefix: --max-consensus-reads
  - id: max_reads_per_guide
    type:
      - 'null'
      - int
    doc: The number randomly selected reads to use within a guide grouping.
    inputBinding:
      position: 103
      prefix: --max-reads-per-guide
  - id: max_uchime_score
    type:
      - 'null'
      - float
    doc: High UCHIME score cutoff.
    inputBinding:
      position: 103
      prefix: --max-uchime-score
  - id: min_cluster_frequency
    type:
      - 'null'
      - float
    doc: Low frequency cluster cutoff.
    inputBinding:
      position: 103
      prefix: --min-cluster-frequency
  - id: min_cluster_read_count
    type:
      - 'null'
      - int
    doc: Low read count cluster cutoff.
    inputBinding:
      position: 103
      prefix: --min-cluster-read-count
  - id: min_read_qv
    type:
      - 'null'
      - float
    doc: Low read QV cutoff.
    inputBinding:
      position: 103
      prefix: --min-read-qv
  - id: min_var_frequency
    type:
      - 'null'
      - float
    doc: Minimum coverage frequency within a pile.
    inputBinding:
      position: 103
      prefix: --min-var-frequency
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: off_target_groups
    type:
      - 'null'
      - string
    doc: Group names to exclude, i.e. these loci are off-target (not amplified).
    inputBinding:
      position: 103
      prefix: --off-target-groups
  - id: pile_size
    type:
      - 'null'
      - int
    doc: The number of best alignments to keep for each read during error correction.
    inputBinding:
      position: 103
      prefix: --pile-size
  - id: seed
    type:
      - 'null'
      - int
    doc: Randomization seed.
    inputBinding:
      position: 103
      prefix: --seed
  - id: trim_ends
    type:
      - 'null'
      - int
    doc: Number of bases to trim from both sides of reads during graph construction
      and variant detection.
    inputBinding:
      position: 103
      prefix: --trim-ends
outputs:
  - id: prefix
    type: File
    doc: Output prefix for run.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbaa:1.2.0--h9ee0642_0
