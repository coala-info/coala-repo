cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sider
  - merge-call
label: sideretro_merge-call
doc: "Discover and annotate retrocopies. Annotates all retrocopies in the first
  input SQLite3 database or generates a new one with all results. Next run
  make-vcf.\n\nTool homepage: https://github.com/galantelab/sideRETRO"
inputs:
  - id: input_list_file
    type:
      - 'null'
      - File
    doc: File containing a newline separated list of SQLite3 databases to be
      processed. Not mandatory if databases are passed as arguments.
    inputBinding:
      position: 1
      prefix: --input-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity to error messages only or suppress terminal outputs
      at all if 'log-file' is passed
    inputBinding:
      position: 1
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Same as quiet
    inputBinding:
      position: 1
      prefix: --silent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Increase verbosity to debug level
    inputBinding:
      position: 1
      prefix: --debug
  - id: log_file
    type:
      - 'null'
      - string
    doc: Print log messages to a file
    inputBinding:
      position: 1
      prefix: --log-file
  - id: output_dir
    type: string
    doc: Output directory. Create the directory if it does not exist.
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix output files [default:"out"]
    inputBinding:
      position: 1
      prefix: --prefix
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Merge all databases with the first one of the list, instead of creating
      a new file
    inputBinding:
      position: 1
      prefix: --in-place
  - id: cache_size
    type:
      - 'null'
      - int
    doc: Set SQLite3 cache size in KiB [default:"200000"]
    inputBinding:
      position: 1
      prefix: --cache-size
  - id: epsilon
    type:
      - 'null'
      - int
    doc: "DBSCAN: Maximum distance between two alignments inside a cluster
      [default:\"300\"]"
    inputBinding:
      position: 1
      prefix: --epsilon
  - id: min_pts
    type:
      - 'null'
      - int
    doc: "DBSCAN: Minimum number of points required to form a dense region
      [default:\"10\"]"
    inputBinding:
      position: 1
      prefix: --min-pts
  - id: blacklist_chr
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --blacklist-chr
    doc: Avoid clustering from and to this chromosome. Can be passed multiple
      times [default:"chrM"]
    inputBinding:
      position: 1
  - id: blacklist_region
    type:
      - 'null'
      - File
    doc: GTF/GFF3/BED blacklisted regions
    inputBinding:
      position: 1
      prefix: --blacklist-region
  - id: blacklist_padding
    type:
      - 'null'
      - int
    doc: Increase the blacklisted regions ranges (left and right) by N bases
      [default:"0"]
    inputBinding:
      position: 1
      prefix: --blacklist-padding
  - id: gff_feature
    type:
      - 'null'
      - string
    doc: The value of 'feature' (third column) for GTF/GFF3 file
      [default:"gene"]
    inputBinding:
      position: 1
      prefix: --gff-feature
  - id: gff_hard_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gff-hard-attribute
    doc: The 'attribute' (ninth column) for GTF/GFF3 file, as key=value (e.g.
      gene_type=pseudogene). Must be true in all of them.
    inputBinding:
      position: 1
  - id: gff_soft_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gff-soft-attribute
    doc: Works as gff_hard_attribute, but needs to be true only once
      [default:"gene_type=processed_pseudogene tag=retrogene"]
    inputBinding:
      position: 1
  - id: parental_distance
    type:
      - 'null'
      - int
    doc: Minimum distance allowed between a cluster and its putative parental
      gene [default:"1000000"]
    inputBinding:
      position: 1
      prefix: --parental-distance
  - id: genotype_support
    type:
      - 'null'
      - int
    doc: Minimum number of reads coming from a given source (SAM/BAM/CRAM)
      within a cluster [default:"1"]
    inputBinding:
      position: 1
      prefix: --genotype-support
  - id: near_gene_rank
    type:
      - 'null'
      - int
    doc: Minimum ranked distance between genes in order to consider them close
      [default:"3"]
    inputBinding:
      position: 1
      prefix: --near-gene-rank
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [default:"1"]
    inputBinding:
      position: 1
      prefix: --threads
  - id: phred_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality used to define reference allele reads
      [default:"8"]
    inputBinding:
      position: 1
      prefix: --phred-quality
  - id: databases
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more SQLite3 databases generated in the process-sample step
    inputBinding:
      position: 2
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the merged SQLite3 database
    outputBinding:
      glob: $(inputs.output_dir)
  - id: updated_databases
    type:
      type: array
      items: File
    doc: SQLite3 databases in the working directory (the first input database is
      updated when in_place is set)
    outputBinding:
      glob: '*.db'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.databases)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
stdout: sideretro_merge-call.out
