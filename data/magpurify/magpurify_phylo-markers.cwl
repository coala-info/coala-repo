cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify phylo-markers
label: magpurify_phylo-markers
doc: "Find taxonomic discordant contigs using a database of phylogenetic marker genes.\n\
  \nTool homepage: https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    inputBinding:
      position: 2
  - id: allow_noclass
    type:
      - 'null'
      - boolean
    doc: Allow a bin to be unclassfied and flag any classified contigs
    inputBinding:
      position: 103
      prefix: --allow_noclass
  - id: bin_fract
    type:
      - 'null'
      - float
    doc: Min fraction of genes in bin that agree with consensus taxonomy for bin
      annotation
    inputBinding:
      position: 103
      prefix: --bin_fract
  - id: contig_fract
    type:
      - 'null'
      - float
    doc: Min fraction of genes in that disagree with bin taxonomy for filtering
    inputBinding:
      position: 103
      prefix: --contig_fract
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Go straight to quality estimation and skip all previous steps
    inputBinding:
      position: 103
      prefix: --continue
  - id: cutoff_type
    type:
      - 'null'
      - string
    doc: Use strict or sensitive %ID cutoff for taxonomically annotating genes
    inputBinding:
      position: 103
      prefix: --cutoff_type
  - id: db
    type:
      - 'null'
      - File
    doc: Path to reference database. By default, the MAGPURIFYDB environmental 
      variable is used
    inputBinding:
      position: 103
      prefix: --db
  - id: exclude_clades
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of clades to exclude (ex: s__1300164.4)'
    inputBinding:
      position: 103
      prefix: --exclude_clades
  - id: hit_type
    type:
      - 'null'
      - string
    doc: Transfer taxonomy of all hits or top hit per gene
    inputBinding:
      position: 103
      prefix: --hit_type
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of targets reported in BLAST table
    inputBinding:
      position: 103
      prefix: --max_target_seqs
  - id: seq_type
    type:
      - 'null'
      - string
    doc: Choose to search genes versus DNA or protein database
    inputBinding:
      position: 103
      prefix: --seq_type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
stdout: magpurify_phylo-markers.out
