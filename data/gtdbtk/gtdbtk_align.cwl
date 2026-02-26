cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk_align
label: gtdbtk_align
doc: "Aligns genomes to create a multiple sequence alignment.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: cols_per_gene
    type:
      - 'null'
      - int
    doc: maximum number of columns to retain per gene when generating the MSA
    default: 42
    inputBinding:
      position: 101
      prefix: --cols_per_gene
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: custom_msa_filters
    type:
      - 'null'
      - boolean
    doc: perform custom filtering of MSA with cols_per_gene, min_consensus 
      max_consensus, and min_perc_taxa parameters instead of using canonical 
      mask
    default: false
    inputBinding:
      position: 101
      prefix: --custom_msa_filters
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: identify_dir
    type: Directory
    doc: output directory of 'identify' command
    inputBinding:
      position: 101
      prefix: --identify_dir
  - id: max_consensus
    type:
      - 'null'
      - float
    doc: maximum percentage of the same amino acid required to retain column 
      (exclusive bound)
    default: 95
    inputBinding:
      position: 101
      prefix: --max_consensus
  - id: min_consensus
    type:
      - 'null'
      - float
    doc: minimum percentage of the same amino acid required to retain column 
      (inclusive bound)
    default: 25
    inputBinding:
      position: 101
      prefix: --min_consensus
  - id: min_perc_aa
    type:
      - 'null'
      - float
    doc: exclude genomes that do not have at least this percentage of AA in the 
      MSA (inclusive bound)
    default: 10
    inputBinding:
      position: 101
      prefix: --min_perc_aa
  - id: min_perc_taxa
    type:
      - 'null'
      - float
    doc: minimum percentage of taxa required to retain column (inclusive bound)
    default: 50
    inputBinding:
      position: 101
      prefix: --min_perc_taxa
  - id: out_dir
    type: Directory
    doc: directory to output files
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for all output files
    default: gtdbtk
    inputBinding:
      position: 101
      prefix: --prefix
  - id: rnd_seed
    type:
      - 'null'
      - int
    doc: random seed to use for selecting columns, e.g. 42
    inputBinding:
      position: 101
      prefix: --rnd_seed
  - id: skip_gtdb_refs
    type:
      - 'null'
      - boolean
    doc: do not include GTDB reference genomes in multiple sequence alignment.
    default: false
    inputBinding:
      position: 101
      prefix: --skip_gtdb_refs
  - id: skip_trimming
    type:
      - 'null'
      - boolean
    doc: skip the trimming step and return the full MSAs
    default: false
    inputBinding:
      position: 101
      prefix: --skip_trimming
  - id: taxa_filter
    type:
      - 'null'
      - string
    doc: 'filter GTDB genomes to taxa (comma separated) within specific taxonomic
      groups (e.g.: d__Bacteria or p__Proteobacteria,p__Actinobacteria)'
    inputBinding:
      position: 101
      prefix: --taxa_filter
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
stdout: gtdbtk_align.out
