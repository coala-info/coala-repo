cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify clade-markers
label: magpurify_clade-markers
doc: "Find taxonomic discordant contigs using a database of clade-specific marker
  genes.\n\nTool homepage: https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: Path to reference database. By default, the MAGPURIFY environmental 
      variable is used
    inputBinding:
      position: 102
      prefix: --db
  - id: exclude_clades
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of clades to exclude (ex: s__Variovorax_sp_CF313)'
    inputBinding:
      position: 102
      prefix: --exclude_clades
  - id: lowest_rank
    type:
      - 'null'
      - string
    doc: Lowest rank for bin classification
    inputBinding:
      position: 102
      prefix: --lowest_rank
  - id: min_bin_fract
    type:
      - 'null'
      - float
    doc: Min fraction of bin length supported by contigs that agree with 
      consensus taxonomy
    inputBinding:
      position: 102
      prefix: --min_bin_fract
  - id: min_contig_fract
    type:
      - 'null'
      - float
    doc: Min fraction of classified contig length that agree with consensus 
      taxonomy
    inputBinding:
      position: 102
      prefix: --min_contig_fract
  - id: min_gene_fract
    type:
      - 'null'
      - float
    doc: Min fraction of classified genes that agree with consensus taxonomy
    inputBinding:
      position: 102
      prefix: --min_gene_fract
  - id: min_genes
    type:
      - 'null'
      - string
    doc: Min number of genes that agree with consensus taxonomy 
      (default=rank-specific-cutoffs)
    inputBinding:
      position: 102
      prefix: --min_genes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
