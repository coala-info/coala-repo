cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon build
label: ganon_build
doc: "Build a Ganon database\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: complete_genomes
    type:
      - 'null'
      - boolean
    doc: 'Download only sub-set of complete genomes (default: False)'
    inputBinding:
      position: 101
      prefix: --complete-genomes
  - id: db_prefix
    type: string
    doc: 'Database output prefix (default: None)'
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: filter_size
    type:
      - 'null'
      - int
    doc: 'Fixed size for filter in Megabytes (MB). Mutually exclusive --max-fp. Only
      valid for --filter-type ibf. (default: 0)'
    inputBinding:
      position: 101
      prefix: --filter-size
  - id: filter_type
    type:
      - 'null'
      - string
    doc: 'Variant of bloom filter to use [hibf, ibf]. hibf requires raptor >= v3.0.1
      installed or binary path set with --raptor-path. --mode, --filter-size and --min-length
      will be ignored with hibf. hibf will set --max-fp 0.001 as default. (default:
      hibf)'
    default: hibf
    inputBinding:
      position: 101
      prefix: --filter-type
  - id: genome_size_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Specific files for genome size estimation - otherwise files will be downloaded
      (default: None)'
    inputBinding:
      position: 101
      prefix: --genome-size-files
  - id: genome_updater
    type:
      - 'null'
      - string
    doc: 'Additional genome_updater parameters (https://github.com/pirovc/genome_updater)
      (default: None)'
    inputBinding:
      position: 101
      prefix: --genome-updater
  - id: hash_functions
    type:
      - 'null'
      - int
    doc: 'The number of hash functions for the interleaved bloom filter [1-5]. With
      --filter-type ibf, 0 will try to set optimal value. (default: 4)'
    default: 4
    inputBinding:
      position: 101
      prefix: --hash-functions
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'The k-mer size to split sequences. (default: 19)'
    default: 19
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: level
    type:
      - 'null'
      - string
    doc: "Highest level to build the database. Options: any available taxonomic rank
      [species, genus, ...], 'leaves' for taxonomic leaves or 'assembly' for a assembly/strain
      based analysis (default: species)"
    inputBinding:
      position: 101
      prefix: --level
  - id: max_fp
    type:
      - 'null'
      - float
    doc: 'Max. false positive for bloom filters. Mutually exclusive --filter-size.
      Defaults to 0.001 with --filter-type hibf or 0.05 with --filter-type ibf. (default:
      None)'
    inputBinding:
      position: 101
      prefix: --max-fp
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Skip sequences smaller then value defined. 0 to not skip any sequence. Only
      valid for --filter-type ibf. (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: --min-length
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Create smaller or faster filters at the cost of classification speed or
      database size, respectively [avg, smaller, smallest, faster, fastest]. If --filter-size
      is used, smaller/smallest refers to the false positive rate. By default, an
      average value is calculated to balance classification speed and database size.
      Only valid for --filter-type ibf. (default: avg)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: organism_group
    type:
      - 'null'
      - type: array
        items: string
    doc: 'One or more organism groups to download [archaea, bacteria, fungi, human,
      invertebrate, metagenomes, other, plant, protozoa, vertebrate_mammalian, vertebrate_other,
      viral]. Mutually exclusive --taxid (default: None)'
    inputBinding:
      position: 101
      prefix: --organism-group
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Quiet output mode (default: False)'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference_genomes
    type:
      - 'null'
      - boolean
    doc: 'Download only sub-set of reference genomes (default: False)'
    inputBinding:
      position: 101
      prefix: --reference-genomes
  - id: restart
    type:
      - 'null'
      - boolean
    doc: 'Restart build/update from scratch, do not try to resume from the latest
      possible step. {db_prefix}_files/ will be deleted if present. (default: False)'
    inputBinding:
      position: 101
      prefix: --restart
  - id: skip_genome_size
    type:
      - 'null'
      - boolean
    doc: 'Do not attempt to get genome sizes. Activate this option when using sequences
      not representing full genomes. (default: False)'
    inputBinding:
      position: 101
      prefix: --skip-genome-size
  - id: source
    type:
      - 'null'
      - type: array
        items: string
    doc: "Source to download [refseq, genbank] (default: ['refseq'])"
    default:
      - refseq
    inputBinding:
      position: 101
      prefix: --source
  - id: taxid
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more taxonomic identifiers to download. e.g. 562 (-x ncbi) or 's__Escherichia
      coli' (-x gtdb). Mutually exclusive --organism-group (default: None)"
    inputBinding:
      position: 101
      prefix: --taxid
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: 'Set taxonomy to enable taxonomic classification, lca and reports [ncbi,
      gtdb, skip] (default: ncbi)'
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: taxonomy_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Specific files for taxonomy - otherwise files will be downloaded (default:
      None)'
    inputBinding:
      position: 101
      prefix: --taxonomy-files
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: top
    type:
      - 'null'
      - int
    doc: 'Download limited assemblies for each taxa. 0 for all. (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: --top
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose output mode (default: False)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'The window-size to build filter with minimizers. (default: 31)'
    default: 31
    inputBinding:
      position: 101
      prefix: --window-size
  - id: write_info_file
    type:
      - 'null'
      - boolean
    doc: 'Save copy of target info generated to {db_prefix}.info.tsv. Can be re-used
      as --input-file for further attempts. (default: False)'
    inputBinding:
      position: 101
      prefix: --write-info-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
stdout: ganon_build.out
