cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - call
label: gembs_gemBS call
doc: "Performs a methylation and SNV calling from bam aligned files. This process
  is performed (optionally in parallel) over contigs. Smaller contigs are processed
  together in pools to increaes efficiency. By default gemBS will analyze all contigs
  / contig pools for all samples that have not already been processed. After all contigs
  have been processed for one sample, the resulting BCFs are merged into a single
  BCF for the sample. This sample BCF is then indexed and the md5 signature calculated.
  If the option --remove is set or 'remove_individual_bcfs' is set to True in the
  configuration file then the individual BAM files will be deleted after the merge
  step has been successfully completed. The --no-merge options will prevent this automatic
  merging - this can be useful for batch processing. Aside from the --no-merge option,
  if no disk based database is being used for gemBS and separate instances of gemBS
  are being run on non-shared file systems then the merging will not always be performed
  automatically. When the merging is not performed automatically for whatever reason,
  it can be invoked manually using the merge- bcfs command. The calling process can
  be restricted to a single sample using the option '-n <SAMPLE NAME>' or '-b <SAMPLE
  BARCODE>'. The mapping can also be restricted to a list of contigs or contig pool
  using the option '-l <contig1, contig2, ...>' or '--pool <pool>'. The --list-pools
  option will list the available contig pools and exit. More information on how contig
  pools are determined is given in the gemBS documentation. If the dbSNP_index key
  has been set in the configuration file (and the index has been gemerated) then this
  will be used by the caller to add public IDs in the BCF file where available. The
  locations of the input and output data are given by the configuration file; see
  the gemBS documentation for details. The --dry-run option will output a list of
  the calling / merging operations that would be run by the call command without executing
  any of the commands. The --json <JSON OUTPUT> options is similar to --dry-run, but
  writes the commands to be executed in JSON format to the supplied output file, including
  information about the input and output files for the commands. The --ignore-db option
  modifies the --dry-run and --json options such that the database is not consulted
  (i.e., gemBS assumes that no calling has already been completed but that all dependencies
  (i.e., BAM files) are available. The --ignore-dep option is similar - it ignores
  dependencies, but does check whether a task has already been completed.\n\nTool
  homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: barcode
    type:
      - 'null'
      - string
    doc: Barcode of sample to be called
    inputBinding:
      position: 101
      prefix: --barcode
  - id: benchmark_mode
    type:
      - 'null'
      - boolean
    doc: Omit dates etc. to make file comparison simpler
    inputBinding:
      position: 101
      prefix: --benchmark-mode
  - id: call_threads
    type:
      - 'null'
      - int
    doc: Number of threads for calling process
    inputBinding:
      position: 101
      prefix: --call-threads
  - id: concat_only
    type:
      - 'null'
      - boolean
    doc: Only perform merging BCF files.
    inputBinding:
      position: 101
      prefix: --concat-only
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: List of contigs on which to perform the methylation calling.
    inputBinding:
      position: 101
      prefix: --contig-list
  - id: conversion
    type:
      - 'null'
      - string
    doc: Set under and over conversion rates (under,over)
    inputBinding:
      position: 101
      prefix: --conversion
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Output mapping commands without execution
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: Force genotype calls to be homozygous
    inputBinding:
      position: 101
      prefix: --haploid
  - id: ignore_db
    type:
      - 'null'
      - boolean
    doc: Ignore database for --dry-run and --json commands
    inputBinding:
      position: 101
      prefix: --ignore-db
  - id: ignore_dep
    type:
      - 'null'
      - boolean
    doc: Ignore dependencies for --dry-run and --json commands
    inputBinding:
      position: 101
      prefix: --ignore-dep
  - id: ignore_duplicate_flag
    type:
      - 'null'
      - boolean
    doc: Ignore duplicate flag from SAM/BAM files.
    inputBinding:
      position: 101
      prefix: --ignore_duplicate_flag
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs
    inputBinding:
      position: 101
      prefix: --jobs
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Do not merge duplicate reads.
    inputBinding:
      position: 101
      prefix: --keep-duplicates
  - id: keep_unmatched
    type:
      - 'null'
      - boolean
    doc: Do not discard reads that do not form proper pairs.
    inputBinding:
      position: 101
      prefix: --keep-unmatched
  - id: left_trim
    type:
      - 'null'
      - int
    doc: Bases to trim from left of read pair
    inputBinding:
      position: 101
      prefix: --left-trim
  - id: list_pools
    type:
      - 'null'
      - string
    doc: List contig pools and exit. Level 1 - list names, level > 1 - list pool
      composition
    inputBinding:
      position: 101
      prefix: --list-pools
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: Threshold for MAPQ scores
    inputBinding:
      position: 101
      prefix: --mapq-threshold
  - id: merge_threads
    type:
      - 'null'
      - int
    doc: Number of threads for merging process
    inputBinding:
      position: 101
      prefix: --merge-threads
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Do not automatically merge BCFs
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: pool
    type:
      - 'null'
      - string
    doc: Contig pool on which to perform the methylation calling.
    inputBinding:
      position: 101
      prefix: --pool
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: Threshold for base quality scores
    inputBinding:
      position: 101
      prefix: --qual-threshold
  - id: reference_bias
    type:
      - 'null'
      - string
    doc: Set bias to reference homozygote
    inputBinding:
      position: 101
      prefix: --reference-bias
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove individual BCF files after merging.
    inputBinding:
      position: 101
      prefix: --remove
  - id: right_trim
    type:
      - 'null'
      - int
    doc: Bases to trim from right of read pair
    inputBinding:
      position: 101
      prefix: --right-trim
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of sample to be called
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: species
    type:
      - 'null'
      - string
    doc: Sample species name.
    inputBinding:
      position: 101
      prefix: --species
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: json_file
    type:
      - 'null'
      - File
    doc: Output JSON file with details of pending commands
    outputBinding:
      glob: $(inputs.json_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
