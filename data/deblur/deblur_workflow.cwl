cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - workflow
label: deblur_workflow
doc: "Launch deblur workflow\n\nTool homepage: https://github.com/biocore/deblur"
inputs:
  - id: error_dist
    type:
      - 'null'
      - string
    doc: A comma separated list of error probabilities for each Hamming 
      distance. The length of the list determines the number of Hamming 
      distances taken into account.
      0.001, 0.0005
    inputBinding:
      position: 101
      prefix: --error-dist
  - id: indel_max
    type:
      - 'null'
      - int
    doc: Maximum number of allowed indels.
    inputBinding:
      position: 101
      prefix: --indel-max
  - id: indel_prob
    type:
      - 'null'
      - float
    doc: Insertion/deletion (indel) probability. This probability consistent for
      multiple indels; there is not an added elongation penalty.
    inputBinding:
      position: 101
      prefix: --indel-prob
  - id: is_worker_thread
    type:
      - 'null'
      - boolean
    doc: indicates this is not the main deblur process (used by the parallel 
      deblur - do not use manually)
    inputBinding:
      position: 101
      prefix: --is-worker-thread
  - id: jobs_to_start
    type:
      - 'null'
      - int
    doc: Number of jobs to start (if to run in parallel)
    inputBinding:
      position: 101
      prefix: --jobs-to-start
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary files (useful for debugging)
    inputBinding:
      position: 101
      prefix: --keep-tmp-files
  - id: left_trim_length
    type:
      - 'null'
      - int
    doc: Trim the first N bases from every sequence. A value of 0 disables this 
      trim.
    inputBinding:
      position: 101
      prefix: --left-trim-length
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file name
    inputBinding:
      position: 101
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of messages for log file(range 1-debug to 5-critical
    inputBinding:
      position: 101
      prefix: --log-level
  - id: mean_error
    type:
      - 'null'
      - float
    doc: The mean per nucleotide error rate, used for original sequence 
      estimate. If not passed typical illumina error rate is used.
    inputBinding:
      position: 101
      prefix: --mean-error
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Keep only the sequences which appear at least min-reads study wide (as 
      opposed to per-sample).
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: min_size
    type:
      - 'null'
      - int
    doc: Keep only sequences which appear at least min-size times per-sample (as
      opposed to study wide).
    inputBinding:
      position: 101
      prefix: --min-size
  - id: neg_ref_db_fp
    type:
      - 'null'
      - type: array
        items: File
    doc: An indexed version of the negative filtering database. If not supplied,
      deblur will index the database.For multiple databases, the order must 
      follow that of --neg-ref-fp, for example, --neg-ref-db-fp db1.idx 
      --neg-ref- db-fp db2.idx ..
    inputBinding:
      position: 101
      prefix: --neg-ref-db-fp
  - id: neg_ref_fp
    type:
      - 'null'
      - type: array
        items: File
    doc: Negative (artifacts) filtering database. Drop all sequences which align
      to any record in this FASTA file. This defaults to a database composed of 
      multiple PhiX genomes and known Illumina adapters. For multiple databases,
      specify the argument mutiple times, e.g., --neg-ref-fp db1.fa --neg-ref- 
      fp db2.fa
    inputBinding:
      position: 101
      prefix: --neg-ref-fp
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if exists.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pos_ref_db_fp
    type:
      - 'null'
      - type: array
        items: File
    doc: An indexed version of the positive filtering database. This can be 
      useful to avoid incurring the expense of reindexing on every run. If not 
      supplied, deblur will index the database. For multiple databases, the 
      order must follow that of --pos-ref-fp, for example, --pos- ref-db-fp 
      db1.idx --pos-ref- db-fp db2.idx ..
    inputBinding:
      position: 101
      prefix: --pos-ref-db-fp
  - id: pos_ref_fp
    type:
      - 'null'
      - type: array
        items: File
    doc: Positive reference filtering database. Keep all sequences permissively 
      aligning to any sequence in this FASTA file; these results are stored in 
      the reference-hit.biom output file. This defaults to the Greengenes 13_8 
      OTUs at 88% identity. An e-value threshold of 10 is used with SortMeRNA 
      against the reference. For multiple databases, specify the argument 
      multiple times, e.g., --pos- ref-fp db1.fa --pos-ref-fp db2.fa
    inputBinding:
      position: 101
      prefix: --pos-ref-fp
  - id: seqs_fp
    type: File
    doc: "Either a Demultiplexed FASTA or FASTQ file\n                           \
      \       including all samples, or a directory of\n                         \
      \         per-sample FASTA or FASTQ files. Gzip'd\n                        \
      \          files are acceptable (e.g., .fastq.gz)."
    inputBinding:
      position: 101
      prefix: --seqs-fp
  - id: threads_per_sample
    type:
      - 'null'
      - int
    doc: Number of threads to use per sample (0 to use all)
    inputBinding:
      position: 101
      prefix: --threads-per-sample
  - id: trim_length
    type: int
    doc: "Sequence trim length. All reads shorter than\n                         \
      \         the trim-length will be discarded. A value\n                     \
      \             of -1 can be specified to skip trimming; this assumes all sequences
      have an identical\n                                  length."
    inputBinding:
      position: 101
      prefix: --trim-length
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory path to store output including\n                             \
      \     BIOM table"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
