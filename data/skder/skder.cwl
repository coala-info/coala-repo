cwlVersion: v1.2
class: CommandLineTool
baseCommand: skder
label: skder
doc: "skDER: efficient & high-resolution dereplication of microbial genomes to select
  representative genomes.\n\nTool homepage: https://github.com/raufs/skDER"
inputs:
  - id: aligned_fraction_cutoff
    type:
      - 'null'
      - float
    doc: Aligned cutoff threshold for dereplication - only needed by one genome
    default: 50.0
    inputBinding:
      position: 101
      prefix: --aligned-fraction-cutoff
  - id: automate
    type:
      - 'null'
      - boolean
    doc: Automatically skip warnings and download genomes from NCBI if -t 
      argument issued. Automatation off by default to prevent unexpected 
      downloading of large genomes
    default: false
    inputBinding:
      position: 101
      prefix: --automate
  - id: dereplication_mode
    type:
      - 'null'
      - string
    doc: Whether to use a "dynamic" (more concise), "greedy" (more 
      comprehensive), or "low_mem_greedy" (currently experimental) approach to 
      selecting representative genomes.
    default: greedy
    inputBinding:
      position: 101
      prefix: --dereplication-mode
  - id: determine_clusters
    type:
      - 'null'
      - boolean
    doc: Perform secondary clustering to assign non-representative genomes to 
      their closest representative genomes.
    inputBinding:
      position: 101
      prefix: --determine-clusters
  - id: filter_mge
    type:
      - 'null'
      - boolean
    doc: Filter predicted MGE coordinates along genomes before dereplication 
      assessment but after N50 computation.
    inputBinding:
      position: 101
      prefix: --filter-mge
  - id: genomad_database
    type:
      - 'null'
      - Directory
    doc: If filter-mge is specified, it will by default use PhiSpy; however, if 
      a database directory for geNomad is provided - it will use that instead to
      predict MGEs.
    inputBinding:
      position: 101
      prefix: --genomad-database
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Genome assembly file paths or paths to containing directories. Files should
      be in FASTA format and can be gzipped (accepted suffices are: *.fasta, *.fa,
      *.fas, or *.fna)'
    inputBinding:
      position: 101
      prefix: --genomes
  - id: gtdb_release
    type:
      - 'null'
      - string
    doc: Which GTDB release to use if -t argument issued
    default: R226
    inputBinding:
      position: 101
      prefix: --gtdb-release
  - id: max_af_distance_cutoff
    type:
      - 'null'
      - float
    doc: Maximum difference for aligned fraction between a pair to automatically
      disqualify the genome with a higher AF from being a representative
    default: 10.0
    inputBinding:
      position: 101
      prefix: --max-af-distance-cutoff
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Max memory in Gigabytes
    default: 0
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: minimal_n50
    type:
      - 'null'
      - int
    doc: Minimal N50 of genomes to be included in dereplication
    default: 0
    inputBinding:
      position: 101
      prefix: --minimal_n50
  - id: output_directory
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: percent_identity_cutoff
    type:
      - 'null'
      - float
    doc: ANI cutoff for dereplication
    default: 99.5
    inputBinding:
      position: 101
      prefix: --percent-identity-cutoff
  - id: sanity_check
    type:
      - 'null'
      - boolean
    doc: Confirm each FASTA file provided or downloaded is actually a FASTA 
      file. Makes it slower, but generally good practice.
    inputBinding:
      position: 101
      prefix: --sanity-check
  - id: skani_triangle_parameters
    type:
      - 'null'
      - string
    doc: Options for skani triangle. Note ANI and AF cutoffs are specified 
      separately and the -E parameter is always requested.
    default: -s X, where X is 10 below the ANI cutoff
    inputBinding:
      position: 101
      prefix: --skani-triangle-parameters
  - id: symlink
    type:
      - 'null'
      - boolean
    doc: Symlink representative genomes in results subdirectory instead of 
      performing a copy of the files.
    inputBinding:
      position: 101
      prefix: --symlink
  - id: taxa_name
    type:
      - 'null'
      - string
    doc: Genus or species identifier from GTDB for which to download genomes for
      and include in dereplication analysis
    inputBinding:
      position: 101
      prefix: --taxa-name
  - id: test_cutoffs
    type:
      - 'null'
      - boolean
    doc: Assess clustering using various pre-selected cutoffs.
    inputBinding:
      position: 101
      prefix: --test-cutoffs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads/processes to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skder:1.3.4--py310h184ae93_1
stdout: skder.out
