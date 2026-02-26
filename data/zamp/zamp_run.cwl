cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - zamp
  - run
label: zamp_run
doc: "Run zAMP\n\nTool homepage: https://github.com/metagenlab/zAMP/"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: amplicon
    type:
      - 'null'
      - string
    doc: Choose 16S or ITS for primer trimming
    default: 16S
    inputBinding:
      position: 102
      prefix: --amplicon
  - id: classifier
    type:
      - 'null'
      - string
    doc: Which classifiers to use for taxonomic assignment
    default: RDP
    inputBinding:
      position: 102
      prefix: --classifier
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: database
    type: Directory
    doc: Path to Database directory
    inputBinding:
      position: 102
      prefix: --database
  - id: denoiser
    type:
      - 'null'
      - string
    doc: Choose dada2 or vsearch for denoising reads
    default: DADA2
    inputBinding:
      position: 102
      prefix: --denoiser
  - id: exclude_rank
    type:
      - 'null'
      - string
    doc: Comma seperated list of ranks to exclude
    default: Phylum
    inputBinding:
      position: 102
      prefix: --exclude-rank
  - id: exclude_taxa
    type:
      - 'null'
      - string
    doc: Comma seperated list of taxa to exclude
    default: Bacteria_phy
    inputBinding:
      position: 102
      prefix: --exclude-taxa
  - id: fw_errors
    type:
      - 'null'
      - int
    doc: Maximum expected errors in R1 for DADA2 denoising
    default: 10
    inputBinding:
      position: 102
      prefix: --fw-errors
  - id: fw_primer
    type: string
    doc: Forward primer sequence to extract amplicon from reads
    inputBinding:
      position: 102
      prefix: --fw-primer
  - id: fw_trim
    type:
      - 'null'
      - int
    doc: Minimum read length to trim low quality ends of R1 for DADA2 denoising
    default: 280
    inputBinding:
      position: 102
      prefix: --fw-trim
  - id: input
    type: File
    doc: Input file/directory for fastq path
    inputBinding:
      position: 102
      prefix: --input
  - id: keep_rank
    type:
      - 'null'
      - string
    doc: Rank to keep taxon
    default: Kingdom
    inputBinding:
      position: 102
      prefix: --keep-rank
  - id: keep_taxa
    type:
      - 'null'
      - string
    doc: Comma seperated list of taxa to keep
    default: Bacteria
    inputBinding:
      position: 102
      prefix: --keep-taxa
  - id: local
    type:
      - 'null'
      - boolean
    doc: Whether reads are local
    inputBinding:
      position: 102
      prefix: --local
  - id: maxlen
    type:
      - 'null'
      - int
    doc: Maximum read length for merged reads
    default: 480
    inputBinding:
      position: 102
      prefix: --maxlen
  - id: melted
    type:
      - 'null'
      - boolean
    doc: Generate melted phyloseq table
    inputBinding:
      position: 102
      prefix: --melted
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to tab seperated metadata file
    inputBinding:
      position: 102
      prefix: --metadata
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimal reads to be kept
    default: 0
    inputBinding:
      position: 102
      prefix: --min-count
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum R1 and R2 overlap for reads merging
    default: 10
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: min_prev
    type:
      - 'null'
      - float
    doc: Proporition (in %) of samples in which the feature has to be found to 
      be kept
    default: 0
    inputBinding:
      position: 102
      prefix: --min-prev
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum read length for merged reads
    default: 390
    inputBinding:
      position: 102
      prefix: --minlen
  - id: name
    type:
      - 'null'
      - string
    doc: Comma seperated list of database names
    inputBinding:
      position: 102
      prefix: --name
  - id: no_melted
    type:
      - 'null'
      - boolean
    doc: Do not generate melted phyloseq table
    inputBinding:
      position: 102
      prefix: --no-melted
  - id: no_replace_empty
    type:
      - 'null'
      - boolean
    doc: Do not replace empty taxa by placeholders
    inputBinding:
      position: 102
      prefix: --no-replace-empty
  - id: no_transposed
    type:
      - 'null'
      - boolean
    doc: Non-transposed count table
    inputBinding:
      position: 102
      prefix: --no-transposed
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Do not trim primers
    inputBinding:
      position: 102
      prefix: --no-trim
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Do not use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: no_use_singularity
    type:
      - 'null'
      - boolean
    doc: Do not use singularity containers for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-singularity
  - id: normalization
    type:
      - 'null'
      - string
    doc: Comma seperated list of values for counts normalization
    default: NONE
    inputBinding:
      position: 102
      prefix: --normalization
  - id: physeq_rank
    type:
      - 'null'
      - string
    doc: Comma seperated list of ranks to collapse on in phyloseq output
    default: OTU
    inputBinding:
      position: 102
      prefix: --physeq-rank
  - id: qiime_viz
    type:
      - 'null'
      - boolean
    doc: Output QIIME visualisation
    default: true
    inputBinding:
      position: 102
      prefix: --qiime-viz
  - id: rarefaction
    type:
      - 'null'
      - string
    doc: Comma seperated list of number of reads for rarefaction
    default: '50000'
    inputBinding:
      position: 102
      prefix: --rarefaction
  - id: replace_empty
    type:
      - 'null'
      - boolean
    doc: Replace empty taxa by placeholders
    inputBinding:
      position: 102
      prefix: --replace-empty
  - id: rv_errors
    type:
      - 'null'
      - int
    doc: Maximum expected errors in R2 for DADA2 denoising
    default: 10
    inputBinding:
      position: 102
      prefix: --rv-errors
  - id: rv_primer
    type: string
    doc: Reverse primer sequence to extract amplicon from reads
    inputBinding:
      position: 102
      prefix: --rv-primer
  - id: rv_trim
    type:
      - 'null'
      - int
    doc: Minimum read length to trim low quality ends of R2 for DADA2 denoising
    default: 255
    inputBinding:
      position: 102
      prefix: --rv-trim
  - id: singularity_prefix
    type:
      - 'null'
      - Directory
    doc: Custom singularity container directory
    inputBinding:
      position: 102
      prefix: --singularity-prefix
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: sra
    type:
      - 'null'
      - boolean
    doc: Whether reads are to be downloaded from NCBI SRA
    inputBinding:
      position: 102
      prefix: --sra
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: transposed
    type:
      - 'null'
      - boolean
    doc: Transposed count table
    inputBinding:
      position: 102
      prefix: --transposed
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim primers
    inputBinding:
      position: 102
      prefix: --trim
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: use_singularity
    type:
      - 'null'
      - boolean
    doc: Use singularity containers for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-singularity
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
