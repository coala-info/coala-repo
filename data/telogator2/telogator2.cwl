cwlVersion: v1.2
class: CommandLineTool
baseCommand: telogator2
label: telogator2
doc: "Telogator\n\nTool homepage: https://github.com/zstephens/telogator2"
inputs:
  - id: all_final_alleles_png_min_atl
    type:
      - 'null'
      - int
    doc: '[ALL_FINAL_ALLELES.PNG] Min ATL to include allele'
    default: 100
    inputBinding:
      position: 101
      prefix: -afa-a
  - id: all_final_alleles_png_xaxis_max
    type:
      - 'null'
      - int
    doc: '[ALL_FINAL_ALLELES.PNG] X axis max'
    default: 15000
    inputBinding:
      position: 101
      prefix: -afa-x
  - id: all_final_alleles_png_xaxis_tick_steps
    type:
      - 'null'
      - int
    doc: '[ALL_FINAL_ALLELES.PNG] X axis tick steps'
    default: 1000
    inputBinding:
      position: 101
      prefix: -afa-t
  - id: atl_method
    type:
      - 'null'
      - string
    doc: 'Method for choosing ATL: mean / median / p75 / max'
    default: p75
    inputBinding:
      position: 101
      prefix: -m
  - id: collapse_hom
    type:
      - 'null'
      - int
    doc: Merge similar alleles mapped <= this bp from each other
    default: 1000
    inputBinding:
      position: 101
      prefix: --collapse-hom
  - id: collapsing_aligned_alleles
    type:
      - 'null'
      - float
    doc: '[TREECUT] Collapsing aligned alleles'
    default: 0.05
    inputBinding:
      position: 101
      prefix: -th
  - id: debug_collapse
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot TVR distances during final collapse'
    inputBinding:
      position: 101
      prefix: --debug-collapse
  - id: debug_dendro
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot dendrogram during init clustering'
    inputBinding:
      position: 101
      prefix: --debug-dendro
  - id: debug_noanchor
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Do not align reads or do any anchoring'
    inputBinding:
      position: 101
      prefix: --debug-noanchor
  - id: debug_nosubtel
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Skip subtel cluster refinement'
    inputBinding:
      position: 101
      prefix: --debug-nosubtel
  - id: debug_progress
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Print progress to screen during init matrix computation'
    inputBinding:
      position: 101
      prefix: --debug-progress
  - id: debug_replot
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Regenerate plots that already exist'
    inputBinding:
      position: 101
      prefix: --debug-replot
  - id: debug_telreads
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Stop immediately after extracting tel reads'
    inputBinding:
      position: 101
      prefix: --debug-telreads
  - id: dont_reprocess
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Use existing intermediary files (for redoing failed runs)'
    inputBinding:
      position: 101
      prefix: --dont-reprocess
  - id: downsample_telomere_reads
    type:
      - 'null'
      - int
    doc: Downsample to this many telomere reads
    default: -1
    inputBinding:
      position: 101
      prefix: -d
  - id: fast_aln
    type:
      - 'null'
      - boolean
    doc: '[PERFORMANCE] Use faster but less accurate pairwise alignment'
    inputBinding:
      position: 101
      prefix: --fast-aln
  - id: filt_nontel
    type:
      - 'null'
      - int
    doc: '[FILTERING] Remove reads that end in > this much non-tel'
    default: 100
    inputBinding:
      position: 101
      prefix: --filt-nontel
  - id: filt_sub
    type:
      - 'null'
      - int
    doc: '[FILTERING] Remove reads that end in < this much subtel'
    default: 1000
    inputBinding:
      position: 101
      prefix: --filt-sub
  - id: filt_tel
    type:
      - 'null'
      - int
    doc: '[FILTERING] Remove reads that end in < this much tel'
    default: 400
    inputBinding:
      position: 101
      prefix: --filt-tel
  - id: input_reads
    type:
      type: array
      items: File
    doc: Input reads (fa / fa.gz / fq / fq.gz / bam)
    inputBinding:
      position: 101
      prefix: -i
  - id: kmers_file
    type:
      - 'null'
      - File
    doc: Telomere kmers file
    default: ''
    inputBinding:
      position: 101
      prefix: -k
  - id: min_hits_canonical_kmer
    type:
      - 'null'
      - int
    doc: Minimum hits to tandem canonical kmer
    default: 8
    inputBinding:
      position: 101
      prefix: -c
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    default: 4000
    inputBinding:
      position: 101
      prefix: -l
  - id: min_reads_per_cluster
    type:
      - 'null'
      - int
    doc: Minimum number of reads per cluster
    default: 3
    inputBinding:
      position: 101
      prefix: -n
  - id: minimap2_exe
    type:
      - 'null'
      - string
    doc: /path/to/minimap2
    default: ''
    inputBinding:
      position: 101
      prefix: --minimap2
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    default: 4
    inputBinding:
      position: 101
      prefix: -p
  - id: pbmm2_exe
    type:
      - 'null'
      - string
    doc: /path/to/pbmm2
    default: ''
    inputBinding:
      position: 101
      prefix: --pbmm2
  - id: plot_filt_tvr
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot denoised TVR instead of raw signal'
    inputBinding:
      position: 101
      prefix: --plot-filt-tvr
  - id: plot_finclust
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot tel reads during final clustering'
    inputBinding:
      position: 101
      prefix: --plot-finclust
  - id: plot_fusions
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot tel fusions for all reads'
    inputBinding:
      position: 101
      prefix: --plot-fusions
  - id: plot_signals
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot tel signals for all reads'
    inputBinding:
      position: 101
      prefix: --plot-signals
  - id: plot_t1clust
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot tel reads during TVR clustering (iteration 1)'
    inputBinding:
      position: 101
      prefix: --plot-t1clust
  - id: plot_t2clust
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] Plot tel reads during TVR clustering (iteration 2)'
    inputBinding:
      position: 101
      prefix: --plot-t2clust
  - id: read_type
    type:
      - 'null'
      - string
    doc: 'Read type: hifi / ont'
    default: ont
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference filename (only needed if input is cram)
    default: ''
    inputBinding:
      position: 101
      prefix: --ref
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: RNG seed value
    default: -1
    inputBinding:
      position: 101
      prefix: --rng
  - id: subtel_cluster_refinement
    type:
      - 'null'
      - float
    doc: '[TREECUT] Subtel cluster refinement'
    default: 0.2
    inputBinding:
      position: 101
      prefix: -ts
  - id: telogator_ref
    type:
      - 'null'
      - File
    doc: Telogator reference fasta
    default: ''
    inputBinding:
      position: 101
      prefix: -t
  - id: tvr_clustering_collapse
    type:
      - 'null'
      - float
    doc: '[TREECUT] TVR clustering (collapse)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: -tc
  - id: tvr_clustering_iter0
    type:
      - 'null'
      - float
    doc: '[TREECUT] TVR clustering (iteration 0)'
    default: 0.2
    inputBinding:
      position: 101
      prefix: -t0
  - id: tvr_clustering_iter1
    type:
      - 'null'
      - float
    doc: '[TREECUT] TVR clustering (iteration 1)'
    default: 0.15
    inputBinding:
      position: 101
      prefix: -t1
  - id: tvr_clustering_iter2
    type:
      - 'null'
      - float
    doc: '[TREECUT] TVR clustering (iteration 2)'
    default: 0.1
    inputBinding:
      position: 101
      prefix: -t2
  - id: violin_atl_png_ploidy
    type:
      - 'null'
      - int
    doc: '[VIOLIN_ATL.PNG] ploidy. i.e. number of alleles per arm'
    default: 2
    inputBinding:
      position: 101
      prefix: -va-p
  - id: violin_atl_png_yaxis_max
    type:
      - 'null'
      - int
    doc: '[VIOLIN_ATL.PNG] Y axis max'
    default: 20000
    inputBinding:
      position: 101
      prefix: -va-y
  - id: violin_atl_png_yaxis_tick_steps
    type:
      - 'null'
      - int
    doc: '[VIOLIN_ATL.PNG] Y axis tick steps'
    default: 5000
    inputBinding:
      position: 101
      prefix: -va-t
  - id: winnowmap_exe
    type:
      - 'null'
      - string
    doc: /path/to/winnowmap
    default: ''
    inputBinding:
      position: 101
      prefix: --winnowmap
  - id: winnowmap_k15_file
    type:
      - 'null'
      - File
    doc: high freq kmers file (only needed for winnowmap)
    default: ''
    inputBinding:
      position: 101
      prefix: --winnowmap-k15
outputs:
  - id: output_dir
    type: Directory
    doc: Path to output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telogator2:2.2.3--pyhdfd78af_0
