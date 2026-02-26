cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama compare_systems
label: panorama_compare_systems
doc: "Compare genomic systems among pangenomes using GFRR metrics\n\nTool homepage:
  https://github.com/labgem/panorama"
inputs:
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Include canonical system versions in the analysis output.
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
      target, 5=shorter and longer seq.'
    default: 0
    inputBinding:
      position: 101
      prefix: --cluster_cov_mode
  - id: cluster_cov_mode
    type:
      - 'null'
      - int
    doc: 'Coverage mode: 0=query, 1=target, 2=shorter seq, 3=longer seq, 4=query and
      target, 5=shorter and longer seq.'
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
    doc: E-value threshold.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --cluster_eval
  - id: cluster_eval
    type:
      - 'null'
      - float
    doc: E-value threshold.
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
    doc: Number of CPU threads to use for parallel processing.
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
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: gfrr_cutoff
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
  - id: gfrr_metrics
    type:
      - 'null'
      - type: array
        items: string
    doc: Similarity metric for clustering conserved systems. Models metrics use 
      only model gene families, while regular metrics use all families.
    inputBinding:
      position: 101
      prefix: --gfrr_metrics
  - id: gfrr_models_cutoff
    type:
      - 'null'
      - type: array
        items: float
    doc: GFRR cutoff thresholds for model gene families comparison. min_gfrr = 
      shared_families / min(families1, families2), max_gfrr = shared_families / 
      max(families1, families2).
    default:
      - 0.4
      - 0.6
    inputBinding:
      position: 101
      prefix: --gfrr_models_cutoff
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
  - id: heatmap
    type:
      - 'null'
      - boolean
    doc: Generate heatmaps showing normalized system presence distribution 
      across pangenomes
    default: false
    inputBinding:
      position: 101
      prefix: --heatmap
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
      (less sensitive), 'cluster' - slower but more sensitive clustering."
    default: linclust
    inputBinding:
      position: 101
      prefix: --method
  - id: method
    type:
      - 'null'
      - string
    doc: "MMSeqs2 clustering method selection: 'linclust' - fast linear-time clustering
      (less sensitive), 'cluster' - slower but more sensitive clustering."
    default: linclust
    inputBinding:
      position: 101
      prefix: --method
  - id: models
    type:
      type: array
      items: File
    doc: Path(s) to model list files. Multiple models can be specified 
      corresponding to different sources. Order must match --sources.
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
    doc: Random seed for reproducibility.
    default: 42
    inputBinding:
      position: 101
      prefix: --seed
  - id: sources
    type:
      type: array
      items: string
    doc: Name(s) of the systems sources. Multiple sources can be specified. 
      Order must match --models argument.
    inputBinding:
      position: 101
      prefix: --sources
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files.
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
