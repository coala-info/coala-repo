cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp place
label: krepp_place
doc: "Place queries on a tree with respect to an index.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: chisq
    type:
      - 'null'
      - float
    doc: Chi-square value for statistical distinguishability test, default 
      correspons to alpha=90%.
    default: 2.706
    inputBinding:
      position: 101
      prefix: --chisq
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter a placement when there is not enough k-mer matches below 
      threshold tau.
    default: true
    inputBinding:
      position: 101
      prefix: --filter
  - id: hdist_th
    type:
      - 'null'
      - int
    doc: Maximum Hamming distance for a k-mer to match.
    default: 4
    inputBinding:
      position: 101
      prefix: --hdist-th
  - id: index_dir
    type: Directory
    doc: Directory <path> containing the reference index.
    inputBinding:
      position: 101
      prefix: --index-dir
  - id: lineage_file
    type:
      - 'null'
      - File
    doc: Path to the Greengenes/GTDB style taxonomic lineage file, the first 
      column has to match reference IDs present in the index (tolerates missing 
      IDs).
    inputBinding:
      position: 101
      prefix: --lineage-file
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Output all candidate placements satisfying the filters (not just the 
      largest clade).
    default: true
    inputBinding:
      position: 101
      prefix: --multi
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Filter a placement when there is not enough k-mer matches below 
      threshold tau.
    default: false
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: no_multi
    type:
      - 'null'
      - boolean
    doc: Output all candidate placements satisfying the filters (not just the 
      largest clade).
    default: false
    inputBinding:
      position: 101
      prefix: --no-multi
  - id: no_summarize
    type:
      - 'null'
      - boolean
    doc: Summarize results into a table of read counts. If a read is 
      mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi 
      and --no-filter.
    default: false
    inputBinding:
      position: 101
      prefix: --no-summarize
  - id: no_tabular
    type:
      - 'null'
      - boolean
    doc: Output the per query sequence placements (taxonomic/phylogenetic) in a 
      tab-separated format.
    default: false
    inputBinding:
      position: 101
      prefix: --no-tabular
  - id: nwk_file
    type:
      - 'null'
      - File
    doc: Path to the Newick file for the (rooted) placement tree (overrides if 
      the index has a backbone tree).
    inputBinding:
      position: 101
      prefix: --nwk-file
  - id: query
    type: File
    doc: Query FASTA/FASTQ file <path> (or URL) (gzip compatible).
    inputBinding:
      position: 101
      prefix: --query
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: Summarize results into a table of read counts. If a read is 
      mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi 
      and --no-filter.
    default: false
    inputBinding:
      position: 101
      prefix: --summarize
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: Output the per query sequence placements (taxonomic/phylogenetic) in a 
      tab-separated format.
    default: false
    inputBinding:
      position: 101
      prefix: --tabular
  - id: tau
    type:
      - 'null'
      - int
    doc: Highest Hamming distance for placement threshold (increase to relax).
    default: 2
    inputBinding:
      position: 101
      prefix: --tau
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Write output to a file at <path>.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
