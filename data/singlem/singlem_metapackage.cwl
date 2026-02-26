cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem metapackage
label: singlem_metapackage
doc: "Create or describe a metapackage (i.e. set of SingleM packages)\n\nTool homepage:
  https://github.com/wwood/singlem"
inputs:
  - id: calculate_average_num_genes_per_species
    type:
      - 'null'
      - boolean
    doc: Calculate the average number of genes per species in the metapackage.
    default: false
    inputBinding:
      position: 101
      prefix: --calculate-average-num-genes-per-species
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: describe
    type:
      - 'null'
      - boolean
    doc: Describe a metapackage rather than create it
    inputBinding:
      position: 101
      prefix: --describe
  - id: diamond_prefilter_performance_parameters
    type:
      - 'null'
      - string
    doc: Performance-type arguments to use when calling 'diamond blastx' during 
      the prefiltering.
    default: --block-size 0.5 --target-indexed -c1
    inputBinding:
      position: 101
      prefix: --diamond-prefilter-performance-parameters
  - id: diamond_taxonomy_assignment_performance_parameters
    type:
      - 'null'
      - string
    doc: Performance-type arguments to use when calling 'diamond blastx' during 
      the taxonomy assignment.
    default: --block-size 0.5 --target-indexed -c1
    inputBinding:
      position: 101
      prefix: --diamond-taxonomy-assignment-performance-parameters
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: makeidx_sensitivity_params
    type:
      - 'null'
      - string
    doc: DIAMOND sensitivity parameters to use when indexing the prefilter 
      DIAMOND db.
    default: None
    inputBinding:
      position: 101
      prefix: --makeidx-sensitivity-params
  - id: metapackage
    type:
      - 'null'
      - string
    doc: Path to write generated metapackage to
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: no_nucleotide_sdb
    type:
      - 'null'
      - boolean
    doc: Skip nucleotide SingleM database
    inputBinding:
      position: 101
      prefix: --no-nucleotide-sdb
  - id: no_taxon_genome_lengths
    type:
      - 'null'
      - boolean
    doc: Skip taxon genome lengths
    inputBinding:
      position: 101
      prefix: --no-taxon-genome-lengths
  - id: nucleotide_sdb
    type:
      - 'null'
      - File
    doc: Nucleotide SingleM database for initial assignment pass
    inputBinding:
      position: 101
      prefix: --nucleotide-sdb
  - id: prefilter_clustering_threshold
    type:
      - 'null'
      - float
    doc: ID for dereplication of prefilter DB
    default: 0.6
    inputBinding:
      position: 101
      prefix: --prefilter-clustering-threshold
  - id: prefilter_diamond_db
    type:
      - 'null'
      - File
    doc: Dereplicated DIAMOND db for prefilter to use
    inputBinding:
      position: 101
      prefix: --prefilter-diamond-db
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: singlem_packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Input packages
    inputBinding:
      position: 101
      prefix: --singlem-packages
  - id: taxon_genome_lengths
    type:
      - 'null'
      - File
    doc: TSV file of genome lengths for each taxon
    inputBinding:
      position: 101
      prefix: --taxon-genome-lengths
  - id: taxonomy_database_name
    type:
      - 'null'
      - string
    doc: Name of the taxonomy database to use
    default: custom_taxonomy_database
    inputBinding:
      position: 101
      prefix: --taxonomy-database-name
  - id: taxonomy_database_version
    type:
      - 'null'
      - string
    doc: Version of the taxonomy database to use
    default: unspecified
    inputBinding:
      position: 101
      prefix: --taxonomy-database-version
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUS to use
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
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_metapackage.out
