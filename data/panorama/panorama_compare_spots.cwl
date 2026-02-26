cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama compare_spots
label: panorama_compare_spots
doc: "Compare and identify conserved spots across multiple pangenomes. This analysis
  identifies genomic regions that are conserved across different pangenomes based
  on gene family similarity and optionally analyzes systems relationships within these
  regions.\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Include canonical versions of systems in the analysis. This provides 
      additional system representations that may be useful for comprehensive 
      systems analysis.
    default: false
    inputBinding:
      position: 101
      prefix: --canonical
  - id: cluster
    type:
      - 'null'
      - File
    doc: Path to tab-separated file with pre-computed clustering results 
      (cluster_name\tfamiliy_id format). If not provided, clustering will be 
      performed.
    inputBinding:
      position: 101
      prefix: --cluster
  - id: cluster_align_mode
    type:
      - 'null'
      - int
    doc: 'Alignment mode: 0=automatic, 1=only score, 2=only extended, 3=score+extended,
      4=fast+extended'
    inputBinding:
      position: 101
      prefix: --cluster_align_mode
  - id: cluster_comp_bias_corr
    type:
      - 'null'
      - int
    doc: 'Compositional bias correction: 0=disabled, 1=enabled'
    inputBinding:
      position: 101
      prefix: --cluster_comp_bias_corr
  - id: cluster_cov_mode
    type:
      - 'null'
      - int
    doc: 'Coverage mode: 0=query, 1=target, 2=shorter seq, 3=longer seq, 4=query and
      target, 5=shorter and longer seq. Default: 0'
    default: 0
    inputBinding:
      position: 101
      prefix: --cluster_cov_mode
  - id: cluster_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage threshold (0.0-1.0).
    default: 0.8
    inputBinding:
      position: 101
      prefix: --cluster_coverage
  - id: cluster_eval
    type:
      - 'null'
      - float
    doc: 'E-value threshold. Default: 0.001'
    default: 0.001
    inputBinding:
      position: 101
      prefix: --cluster_eval
  - id: cluster_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity threshold (0.0-1.0).
    default: 0.5
    inputBinding:
      position: 101
      prefix: --cluster_identity
  - id: cluster_kmer_per_seq
    type:
      - 'null'
      - int
    doc: Number of k-mers per sequence
    inputBinding:
      position: 101
      prefix: --cluster_kmer_per_seq
  - id: cluster_max_reject
    type:
      - 'null'
      - int
    doc: Maximum number of rejected sequences
    inputBinding:
      position: 101
      prefix: --cluster_max_reject
  - id: cluster_max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 101
      prefix: --cluster_max_seq_len
  - id: cluster_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of sequences per cluster representative (cluster method 
      only)
    inputBinding:
      position: 101
      prefix: --cluster_max_seqs
  - id: cluster_min_ungapped
    type:
      - 'null'
      - int
    doc: Minimum ungapped alignment score (cluster method only)
    inputBinding:
      position: 101
      prefix: --cluster_min_ungapped
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: 'Clustering mode: 0=Set Cover, 1=Connected Component, 2=Greedy, 3=Greedy
      Low Memory'
    inputBinding:
      position: 101
      prefix: --cluster_mode
  - id: cluster_sensitivity
    type:
      - 'null'
      - float
    doc: Search sensitivity (cluster method only). Higher values = more 
      sensitive but slower
    inputBinding:
      position: 101
      prefix: --cluster_sensitivity
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads to use for parallel processing. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    default: false
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: dup_margin
    type:
      - 'null'
      - float
    doc: "Minimum ratio of genomes in which a gene family must have multiple copies
      to be considered 'duplicated'. This affects multigenic family detection for
      spot border analysis. Range: 0.0-1.0. Default: 0.05 (5%)"
    default: 0.05
    inputBinding:
      position: 101
      prefix: --dup_margin
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: gfrr_metrics
    type:
      - 'null'
      - string
    doc: "GFRR metric used for spots clustering. 'min_gfrr': conservative metric (shared/smaller_set),
      'max_gfrr': liberal metric (shared/larger_set). Default: min_gfrr"
    default: min_gfrr
    inputBinding:
      position: 101
      prefix: --gfrr_metrics
  - id: graph_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Output format(s) for graph files. Multiple formats can be specified. Supported:
      gexf (Gephi Exchange Format), graphml (Graph Markup Language)'
    inputBinding:
      position: 101
      prefix: --graph_formats
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files after completion (useful for debugging and 
      inspection)
    default: false
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: method
    type:
      - 'null'
      - string
    doc: "MMSeqs2 clustering method selection: 'linclust' - fast linear-time clustering
      (less sensitive), 'cluster' - slower but more sensitive clustering. Default:
      linclust"
    default: linclust
    inputBinding:
      position: 101
      prefix: --method
  - id: min_frr
    type:
      - 'null'
      - type: array
        items: float
    doc: FRR (Family Relatedness Relationship) cutoff values for similarity 
      assessment. min_gfrr = shared_families / min(families1, families2), 
      max_gfrr = shared_families / max(families1, families2)
    default:
      - 0.5
      - 0.8
    inputBinding:
      position: 101
      prefix: --gfrr_cutoff
  - id: model_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to system model files. Multiple model files can be specified 
      (space-separated) for different system sources. Must be provided in the 
      same order as --sources. Required if --systems is used.
    inputBinding:
      position: 101
      prefix: --models
  - id: pangenomes
    type: File
    doc: Path to TSV file containing list of pangenome .h5 files to compare
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed for reproducibility. Default: 42'
    default: 42
    inputBinding:
      position: 101
      prefix: --seed
  - id: source_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Name(s) of systems sources corresponding to model files. Multiple 
      sources can be specified (space-separated). Must be provided in the same 
      order as --models. Required if --systems is used.
    inputBinding:
      position: 101
      prefix: --sources
  - id: systems
    type:
      - 'null'
      - boolean
    doc: Enable systems analysis to examine relationships between conserved 
      spots and detected biological systems. This adds systems linkage graphs 
      and enriched annotations to the output.
    default: false
    inputBinding:
      position: 101
      prefix: --systems
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: 'Directory for temporary files. Default: /tmp'
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    default: 1
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory where result files will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
