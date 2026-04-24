cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfStats
label: biopet-vcfstats
doc: "A tool to generate statistics from VCF files, including general, genotype, and
  sample comparison stats.\n\nTool homepage: https://github.com/biopet/vcfstats"
inputs:
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Binsize in estimated base pairs
    inputBinding:
      position: 101
      prefix: --binSize
  - id: execute_modules_as_jobs
    type:
      - 'null'
      - boolean
    doc: Execute modules as jobs (only in spark mode)
    inputBinding:
      position: 101
      prefix: --executeModulesAsJobs
  - id: genotype_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Summarize these genotype tags
    inputBinding:
      position: 101
      prefix: --genotypeTag
  - id: info_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Summarize these info tags
    inputBinding:
      position: 101
      prefix: --infoTag
  - id: input_file
    type: File
    doc: Input VCF file (required)
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: intervals
    type:
      - 'null'
      - File
    doc: Path to interval (BED) file (optional)
    inputBinding:
      position: 101
      prefix: --intervals
  - id: local_threads
    type:
      - 'null'
      - int
    doc: Number of local threads to use
    inputBinding:
      position: 101
      prefix: --localThreads
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: max_contigs_in_single_job
    type:
      - 'null'
      - int
    doc: Max number of bins to be combined, default is 250
    inputBinding:
      position: 101
      prefix: --maxContigsInSingleJob
  - id: not_write_contig_stats
    type:
      - 'null'
      - boolean
    doc: Number of local threads to use
    inputBinding:
      position: 101
      prefix: --notWriteContigStats
  - id: reference_file
    type: File
    doc: Fasta reference which was used to call input VCF (required)
    inputBinding:
      position: 101
      prefix: --referenceFile
  - id: repartition
    type:
      - 'null'
      - boolean
    doc: Repartition after reading records (only in spark mode)
    inputBinding:
      position: 101
      prefix: --repartition
  - id: sample_to_sample_min_depth
    type:
      - 'null'
      - int
    doc: Minimal depth require to consider sample to sample comparison
    inputBinding:
      position: 101
      prefix: --sampleToSampleMinDepth
  - id: skip_general
    type:
      - 'null'
      - boolean
    doc: Skipping general stats
    inputBinding:
      position: 101
      prefix: --skipGeneral
  - id: skip_genotype
    type:
      - 'null'
      - boolean
    doc: Skipping genotype stats
    inputBinding:
      position: 101
      prefix: --skipGenotype
  - id: skip_sample_compare
    type:
      - 'null'
      - boolean
    doc: Skipping sample compare
    inputBinding:
      position: 101
      prefix: --skipSampleCompare
  - id: skip_sample_distributions
    type:
      - 'null'
      - boolean
    doc: Skipping sample distributions stats
    inputBinding:
      position: 101
      prefix: --skipSampleDistributions
  - id: spark_config_value
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add values to the spark config (format: key=value)'
    inputBinding:
      position: 101
      prefix: --sparkConfigValue
  - id: spark_executor_memory
    type:
      - 'null'
      - string
    doc: Spark executor memory to use
    inputBinding:
      position: 101
      prefix: --sparkExecutorMemory
  - id: spark_master
    type:
      - 'null'
      - string
    doc: Spark master to use
    inputBinding:
      position: 101
      prefix: --sparkMaster
  - id: write_bin_stats
    type:
      - 'null'
      - boolean
    doc: Write bin statistics. Default False
    inputBinding:
      position: 101
      prefix: --writeBinStats
outputs:
  - id: output_dir
    type: Directory
    doc: Path to directory for output (required)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-vcfstats:1.2--0
