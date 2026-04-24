cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtdbtk
  - de_novo_wf
label: gtdbtk_de_novo_wf
doc: "De novo workflow for GTDB-Tk\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: archaea
    type: boolean
    doc: 'process archaeal genomes (default: False)'
    inputBinding:
      position: 101
      prefix: --archaea
  - id: bacteria
    type: boolean
    doc: 'process bacterial genomes (default: False)'
    inputBinding:
      position: 101
      prefix: --bacteria
  - id: batchfile
    type: File
    doc: path to file describing genomes - tab separated in 2 or 3 columns 
      (FASTA file, genome ID, translation table [optional])
    inputBinding:
      position: 101
      prefix: --batchfile
  - id: cols_per_gene
    type:
      - 'null'
      - int
    doc: 'maximum number of columns to retain per gene when generating the MSA (default:
      42)'
    inputBinding:
      position: 101
      prefix: --cols_per_gene
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'number of CPUs to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: custom_msa_filters
    type:
      - 'null'
      - boolean
    doc: 'perform custom filtering of MSA with cols_per_gene, min_consensus max_consensus,
      and min_perc_taxa parameters instead of using canonical mask (default: False)'
    inputBinding:
      position: 101
      prefix: --custom_msa_filters
  - id: custom_taxonomy_file
    type:
      - 'null'
      - File
    doc: 'file indicating custom taxonomy strings for user genomes, that should contain
      any genomes belonging to the outgroup. Format: GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__'
    inputBinding:
      position: 101
      prefix: --custom_taxonomy_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'create intermediate files for debugging purposes (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of files to process, gz = gzipped (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'continue processing if an error occurs on a single genome (default: False)'
    inputBinding:
      position: 101
      prefix: --force
  - id: gamma
    type:
      - 'null'
      - boolean
    doc: 'rescale branch lengths to optimize the Gamma20 likelihood (default: False)'
    inputBinding:
      position: 101
      prefix: --gamma
  - id: genes
    type:
      - 'null'
      - boolean
    doc: 'indicates input files contain predicted proteins as amino acids (skip gene
      calling).Warning: This flag will skip the ANI comparison steps (ANI screen and
      classification). (default: False)'
    inputBinding:
      position: 101
      prefix: --genes
  - id: genome_dir
    type: Directory
    doc: directory containing genome files in FASTA format
    inputBinding:
      position: 101
      prefix: --genome_dir
  - id: gtdbtk_classification_file
    type:
      - 'null'
      - File
    doc: file with GTDB-Tk classifications produced by the `classify` command
    inputBinding:
      position: 101
      prefix: --gtdbtk_classification_file
  - id: keep_intermediates
    type:
      - 'null'
      - boolean
    doc: 'keep intermediate files in the final directory (default: False)'
    inputBinding:
      position: 101
      prefix: --keep_intermediates
  - id: max_consensus
    type:
      - 'null'
      - float
    doc: 'maximum percentage of the same amino acid required to retain column (exclusive
      bound) (default: 95)'
    inputBinding:
      position: 101
      prefix: --max_consensus
  - id: min_consensus
    type:
      - 'null'
      - float
    doc: 'minimum percentage of the same amino acid required to retain column (inclusive
      bound) (default: 25)'
    inputBinding:
      position: 101
      prefix: --min_consensus
  - id: min_perc_aa
    type:
      - 'null'
      - float
    doc: 'exclude genomes that do not have at least this percentage of AA in the MSA
      (inclusive bound) (default: 10)'
    inputBinding:
      position: 101
      prefix: --min_perc_aa
  - id: min_perc_taxa
    type:
      - 'null'
      - float
    doc: 'minimum percentage of taxa required to retain column (inclusive bound) (default:
      50)'
    inputBinding:
      position: 101
      prefix: --min_perc_taxa
  - id: no_support
    type:
      - 'null'
      - boolean
    doc: 'do not compute local support values using the Shimodaira-Hasegawa test (default:
      False)'
    inputBinding:
      position: 101
      prefix: --no_support
  - id: out_dir
    type: Directory
    doc: directory to output files
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: outgroup_taxon
    type: string
    doc: taxon to use as outgroup (e.g., p__Patescibacteriota or 
      p__Altiarchaeota)
    inputBinding:
      position: 101
      prefix: --outgroup_taxon
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'prefix for all output files (default: gtdbtk)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: prot_model
    type:
      - 'null'
      - string
    doc: 'protein substitution model for tree inference (default: WAG)'
    inputBinding:
      position: 101
      prefix: --prot_model
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
    doc: 'do not include GTDB reference genomes in multiple sequence alignment. (default:
      False)'
    inputBinding:
      position: 101
      prefix: --skip_gtdb_refs
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
    doc: 'specify alternative directory for temporary files (default: /tmp)'
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: write_single_copy_genes
    type:
      - 'null'
      - boolean
    doc: 'output unaligned single-copy marker genes (default: False)'
    inputBinding:
      position: 101
      prefix: --write_single_copy_genes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
stdout: gtdbtk_de_novo_wf.out
