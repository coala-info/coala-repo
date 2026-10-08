cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - compare_context
label: panorama_compare_context
doc: "Comparison of modules and gene contexts among pangenomes\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: cluster
    type:
      - 'null'
      - File
    doc: Path to tab-separated file with pre-computed clustering results (cluster_name\tfamiliy_id
      format). If not provided, clustering will be performed.
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
    inputBinding:
      position: 101
      prefix: --cluster_cov_mode
  - id: cluster_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage threshold (0.0-1.0).
    inputBinding:
      position: 101
      prefix: --cluster_coverage
  - id: cluster_eval
    type:
      - 'null'
      - float
    doc: 'E-value threshold. Default: 0.001'
    inputBinding:
      position: 101
      prefix: --cluster_eval
  - id: cluster_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity threshold (0.0-1.0).
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
    doc: Maximum number of sequences per cluster representative (cluster method only)
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
    doc: Search sensitivity (cluster method only). Higher values = more sensitive
      but slower
    inputBinding:
      position: 101
      prefix: --cluster_sensitivity
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads to use for parallel processing. Default: 1'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
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
    doc: Keep temporary files after completion (useful for debugging and inspection)
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - string
    doc: Log output file name
    inputBinding:
      position: 101
      prefix: --log
  - id: method
    type:
      - 'null'
      - string
    doc: 'MMSeqs2 clustering method selection: ''linclust'' - fast linear-time clustering
      (less sensitive), ''cluster'' - slower but more sensitive clustering. Default:
      linclust'
    inputBinding:
      position: 101
      prefix: --method
  - id: gfrr_cutoff
    type:
      - 'null'
      - type: array
        items: float
    doc: FRR (Family Relatedness Relationship) cutoff values for similarity assessment.
      min_gfrr = shared_families / min(families1, families2), max_gfrr = shared_families
      / max(families1, families2) - 0.5 - 0.8
    inputBinding:
      position: 101
      prefix: --gfrr_cutoff
  - id: pangenomes
    type: File
    doc: Path to TSV file containing list of pangenome .h5 files to compare
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: pangenome_files
    type:
      type: array
      items: File
    doc: Pangenome .h5 files named in the pangenomes list. They are staged in the
      working directory, so the list must name them by file name (second column).
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed for reproducibility. Default: 42'
    inputBinding:
      position: 101
      prefix: --seed
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: 'Directory for temporary files. Default: /tmp'
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 for
      debug)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: context_results
    type:
      - 'null'
      - File
    doc: 'Already computed contexts: Tsv file with two columns: name of pangenome
      and path to the corresponding context results. Results can be a table (tsv)
      or a graph (graphml or gexf)'
    inputBinding:
      position: 101
      prefix: --context_results
  - id: context_result_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Context result files (tsv, graphml or gexf) named in the context_results
      list. They are staged in the working directory, so the list must name them by
      file name.
  - id: sequences
    type:
      - 'null'
      - File
    doc: Fasta file with the sequences of interest
    inputBinding:
      position: 101
      prefix: --sequences
  - id: families
    type:
      - 'null'
      - File
    doc: List of family IDs of interest from the pan
    inputBinding:
      position: 101
      prefix: --families
  - id: synteny_score
    type:
      - 'null'
      - float
    doc: minimum synteny score used to filter edges between genomic contexts.
    inputBinding:
      position: 101
      prefix: --synteny_score
  - id: transitive
    type:
      - 'null'
      - int
    doc: Size of the transitive closure used to build the graph. This indicates the
      number of non-related genes allowed in-between two related genes. Increasing
      it will improve precision but lower sensitivity a little.
    inputBinding:
      position: 101
      prefix: --transitive
  - id: window
    type:
      - 'null'
      - int
    doc: Number of neighboring genes that are considered on each side of a gene of
      interest when searching for conserved genomic contexts.
    inputBinding:
      position: 101
      prefix: --window
  - id: jaccard
    type:
      - 'null'
      - float
    doc: Minimum Jaccard similarity used to filter edges between gene families. Increasing
      it will improve precision but lower sensitivity a lot.
    inputBinding:
      position: 101
      prefix: --jaccard
  - id: graph_format
    type:
      - 'null'
      - string
    doc: Format of the context graph. Can be gexf or graphml.
    inputBinding:
      position: 101
      prefix: --graph_format
  - id: align_identity
    type:
      - 'null'
      - float
    doc: 'Minimum identity percentage threshold (0.0-1.0). Default: 0.8'
    inputBinding:
      position: 101
      prefix: --align_identity
  - id: align_coverage
    type:
      - 'null'
      - float
    doc: 'Minimum coverage percentage threshold (0.0-1.0). Default: 0.8'
    inputBinding:
      position: 101
      prefix: --align_coverage
  - id: align_cov_mode
    type:
      - 'null'
      - int
    doc: 'Coverage mode: 0=query, 1=target, 2=shorter seq, 3=longer seq, 4=query and
      target, 5=shorter and longer seq. Default: 0'
    inputBinding:
      position: 101
      prefix: --align_cov_mode
  - id: translation_table
    type:
      - 'null'
      - int
    doc: The translation table to use when the input sequences are nucleotide sequences.
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory where result files will be written
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (with log)
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pangenome_files)
      - $(inputs.context_result_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
