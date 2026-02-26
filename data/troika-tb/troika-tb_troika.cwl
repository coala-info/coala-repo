cwlVersion: v1.2
class: CommandLineTool
baseCommand: troika
label: troika-tb_troika
doc: "Troika - a pipeline for phylogenentic analysis, detection and reporting of genomic
  AST in Mtb If an arg is specified in more than one place, then commandline values
  override environment variables which override defaults.\n\nTool homepage: https://github.com/kristyhoran/troika"
inputs:
  - id: db_version
    type:
      - 'null'
      - string
    doc: The version of database being used.
    default: TBProfiler-20190820
    inputBinding:
      position: 101
      prefix: --db_version
  - id: detect_species
    type:
      - 'null'
      - boolean
    doc: Set if you would like to detect species - note if not set troika may 
      include non-tuberculosis species in the analysis.
    default: false
    inputBinding:
      position: 101
      prefix: --detect_species
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file tab-delimited file 3 columns isolate_id path_to_r1 
      path_to_r2
    default: ''
    inputBinding:
      position: 101
      prefix: --input_file
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs to run in parallel.
    default: 8
    inputBinding:
      position: 101
      prefix: --jobs
  - id: kraken_db
    type:
      - 'null'
      - string
    doc: 'Path to DB for use with kraken2, if no DB present speciation will not be
      performed. [env var: KRAKEN2_DEFAULT_DB]'
    default: None
    inputBinding:
      position: 101
      prefix: --kraken_db
  - id: kraken_threads
    type:
      - 'null'
      - int
    doc: Number of threads for kraken
    default: 4
    inputBinding:
      position: 101
      prefix: --kraken_threads
  - id: min_aln
    type:
      - 'null'
      - int
    doc: Minimum alignment for phylogenetic analysis, alignments lower than this
      threshold will not be included in the calculation of core-genome.
    default: 80
    inputBinding:
      position: 101
      prefix: --min_aln
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage for quality checks, isolates with coverage below this 
      threshold will not be used in the analysis.
    default: 40
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: mode
    type:
      - 'null'
      - string
    doc: If running for MDU service use 'mdu', else use 'normal'
    default: normal
    inputBinding:
      position: 101
      prefix: --mode
  - id: positive_control
    type: File
    doc: Path to positive control - REQUIRED if running for MDU service
    default: ''
    inputBinding:
      position: 101
      prefix: --positive_control
  - id: profiler_singularity_path
    type:
      - 'null'
      - string
    doc: URL for TB-profiler singularity container.
    default: docker://mduphl/mtbtools
    inputBinding:
      position: 101
      prefix: --profiler_singularity_path
  - id: profiler_threads
    type:
      - 'null'
      - int
    doc: Number of threads to run TB-profiler
    default: 1
    inputBinding:
      position: 101
      prefix: --profiler_threads
  - id: resistance_only
    type:
      - 'null'
      - boolean
    doc: If detection of resistance mutations only is needed. Phylogeny will not
      be performed.
    default: false
    inputBinding:
      position: 101
      prefix: --resistance_only
  - id: resources
    type:
      - 'null'
      - Directory
    doc: Directory where templates are stored
    default: /usr/local/lib/python3.9/site-packages/troika_tb
    inputBinding:
      position: 101
      prefix: --resources
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: If singularity is to be used for troika.
    default: false
    inputBinding:
      position: 101
      prefix: --Singularity
  - id: snippy_singularity_path
    type:
      - 'null'
      - string
    doc: URL for Snippy singularity container.
    default: docker://mduphl/snippy:v4.4.3
    inputBinding:
      position: 101
      prefix: --snippy_singularity_path
  - id: snippy_threads
    type:
      - 'null'
      - int
    doc: Number of threads for snippy
    default: 8
    inputBinding:
      position: 101
      prefix: --snippy_threads
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Working directory, default is current directory
    default: /
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/troika-tb:0.0.5--py_0
stdout: troika-tb_troika.out
