cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dRep
  - dereplicate
label: drep_dRep dereplicate
doc: "Dereplicate genomes based on ANI and other quality metrics.\n\nTool homepage:
  https://github.com/MrOlm/drep"
inputs:
  - id: work_directory
    type: Directory
    doc: Directory where data and output are stored. *** USE THE SAME WORK 
      DIRECTORY FOR ALL DREP OPERATIONS ***
    inputBinding:
      position: 1
  - id: centrality_weight
    type:
      - 'null'
      - float
    doc: Weight of (centrality - S_ani)
    default: 1
    inputBinding:
      position: 102
      prefix: --centrality_weight
  - id: checkm_group_size
    type:
      - 'null'
      - int
    doc: The number of genomes passed to checkM at a time. Increasing this 
      increases RAM but makes checkM faster
    default: 2000
    inputBinding:
      position: 102
      prefix: --checkm_group_size
  - id: checkm_method
    type:
      - 'null'
      - string
    doc: Either lineage_wf (more accurate) or taxonomy_wf (faster)
    default: lineage_wf
    inputBinding:
      position: 102
      prefix: --checkM_method
  - id: cluster_alg
    type:
      - 'null'
      - string
    doc: Algorithm used to cluster genomes (passed to 
      scipy.cluster.hierarchy.linkage
    default: average
    inputBinding:
      position: 102
      prefix: --clusterAlg
  - id: completeness
    type:
      - 'null'
      - float
    doc: Minimum genome completeness
    default: 75
    inputBinding:
      position: 102
      prefix: --completeness
  - id: completeness_weight
    type:
      - 'null'
      - float
    doc: completeness weight
    default: 1
    inputBinding:
      position: 102
      prefix: --completeness_weight
  - id: contamination
    type:
      - 'null'
      - float
    doc: Maximum genome contamination
    default: 25
    inputBinding:
      position: 102
      prefix: --contamination
  - id: contamination_weight
    type:
      - 'null'
      - float
    doc: contamination weight
    default: 5
    inputBinding:
      position: 102
      prefix: --contamination_weight
  - id: cov_thresh
    type:
      - 'null'
      - float
    doc: Minmum level of overlap between genomes when doing secondary 
      comparisons
    default: 0.1
    inputBinding:
      position: 102
      prefix: --cov_thresh
  - id: coverage_method
    type:
      - 'null'
      - string
    doc: "Method to calculate coverage of an alignment (for ANIn/ANImf only; gANI
      and fastANI can only do larger method)\ntotal   = 2*(aligned length) / (sum
      of total genome lengths)\nlarger  = max((aligned length / genome 1), (aligned_length
      / genome2))"
    default: larger
    inputBinding:
      position: 102
      prefix: --coverage_method
  - id: debug
    type:
      - 'null'
      - boolean
    doc: make extra debugging output
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: extra_weight_table
    type:
      - 'null'
      - File
    doc: Path to a tab-separated file with two-columns, no headers, listing 
      genome and extra score to apply to that genome
    inputBinding:
      position: 102
      prefix: --extra_weight_table
  - id: gen_warnings
    type:
      - 'null'
      - boolean
    doc: Generate warnings
    default: false
    inputBinding:
      position: 102
      prefix: --gen_warnings
  - id: genome_info
    type:
      - 'null'
      - File
    doc: 'location of .csv file containing quality information on the genomes. Must
      contain: ["genome"(basename of .fasta file of that genome), "completeness"(0-100
      value for completeness of the genome), "contamination"(0-100 value of the contamination
      of the genome)]'
    inputBinding:
      position: 102
      prefix: --genomeInfo
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: genomes to filter in .fasta format. Not necessary if Bdb or Wdb already
      exist. Can also input a text file with paths to genomes, which results in 
      fewer OS issues than wildcard expansion
    inputBinding:
      position: 102
      prefix: --genomes
  - id: greedy_secondary_clustering
    type:
      - 'null'
      - boolean
    doc: Use a heuristic to avoid pair-wise comparisons when doing secondary 
      clustering. Will be done with single linkage clustering. Only works for 
      fastANI S_algorithm option at the moment
    default: false
    inputBinding:
      position: 102
      prefix: --greedy_secondary_clustering
  - id: ignore_genome_quality
    type:
      - 'null'
      - boolean
    doc: Don't run checkM or do any quality filtering. NOT RECOMMENDED! This is 
      useful for use with bacteriophages or eukaryotes or things where checkM 
      scoring does not work. Will only choose genomes based on length and N50
    default: false
    inputBinding:
      position: 102
      prefix: --ignoreGenomeQuality
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum genome length
    default: 50000
    inputBinding:
      position: 102
      prefix: --length
  - id: low_ram_primary_clustering
    type:
      - 'null'
      - boolean
    doc: Use a memory-efficient algorithm for primary clustering. This only 
      affects primary clustering and not secondary clustering.
    default: false
    inputBinding:
      position: 102
      prefix: --low_ram_primary_clustering
  - id: mash_sketch
    type:
      - 'null'
      - int
    doc: MASH sketch size
    default: 1000
    inputBinding:
      position: 102
      prefix: --MASH_sketch
  - id: multiround_primary_clustering
    type:
      - 'null'
      - boolean
    doc: Cluster each primary clunk separately and merge at the end with single 
      linkage. Decreases RAM usage and increases speed, and the cost of a minor 
      loss in precision and the inability to plot 
      primary_clustering_dendrograms. Especially helpful when clustering 5000+ 
      genomes. Will be done with single linkage clustering
    default: false
    inputBinding:
      position: 102
      prefix: --multiround_primary_clustering
  - id: n50_weight
    type:
      - 'null'
      - float
    doc: weight of log(genome N50)
    default: 0.5
    inputBinding:
      position: 102
      prefix: --N50_weight
  - id: n_preset
    type:
      - 'null'
      - string
    doc: "Presets to pass to nucmer\ntight   = only align highly conserved regions\n\
      normal  = default ANIn parameters"
    default: normal
    inputBinding:
      position: 102
      prefix: --n_PRESET
  - id: p_ani
    type:
      - 'null'
      - float
    doc: ANI threshold to form primary (MASH) clusters
    default: 0.9
    inputBinding:
      position: 102
      prefix: --P_ani
  - id: primary_chunksize
    type:
      - 'null'
      - int
    doc: Impacts multiround_primary_clustering. If you have more than this many 
      genomes, process them in chunks of this size.
    default: 5000
    inputBinding:
      position: 102
      prefix: --primary_chunksize
  - id: processors
    type:
      - 'null'
      - int
    doc: threads
    default: 6
    inputBinding:
      position: 102
      prefix: --processors
  - id: run_tertiary_clustering
    type:
      - 'null'
      - boolean
    doc: Run an additional round of clustering on the final genome set. This is 
      especially useful when greedy clustering is performed and/or to handle 
      cases where similar genomes end up in different primary clusters. Only 
      works with dereplicate, not compare.
    default: false
    inputBinding:
      position: 102
      prefix: --run_tertiary_clustering
  - id: s_algorithm
    type:
      - 'null'
      - string
    doc: 'Algorithm for secondary clustering comaprisons: fastANI = Kmer-based approach;
      very fast skani = Even faster Kmer-based approacht ANImf   = (DEFAULT) Align
      whole genomes with nucmer; filter alignment; compare aligned regions ANIn    =
      Align whole genomes with nucmer; compare aligned regions gANI    = Identify
      and align ORFs; compare aligned ORFS goANI   = Open source version of gANI;
      requires nsmimscan'
    default: fastANI
    inputBinding:
      position: 102
      prefix: --S_algorithm
  - id: s_ani
    type:
      - 'null'
      - float
    doc: ANI threshold to form secondary clusters
    default: 0.95
    inputBinding:
      position: 102
      prefix: --S_ani
  - id: set_recursion
    type:
      - 'null'
      - int
    doc: Increases the python recursion limit. NOT RECOMMENDED unless checkM is 
      crashing due to recursion issues. Recommended to set to 2000 if needed, 
      but setting this could crash python
    default: 0
    inputBinding:
      position: 102
      prefix: --set_recursion
  - id: size_weight
    type:
      - 'null'
      - float
    doc: weight of log(genome size)
    default: 0
    inputBinding:
      position: 102
      prefix: --size_weight
  - id: skani_extra
    type:
      - 'null'
      - string
    doc: Extra arguments to pass to skani triangle
    default: ''
    inputBinding:
      position: 102
      prefix: --skani_extra
  - id: skip_mash
    type:
      - 'null'
      - boolean
    doc: Skip MASH clustering, just do secondary clustering on all genomes
    default: false
    inputBinding:
      position: 102
      prefix: --SkipMash
  - id: skip_plots
    type:
      - 'null'
      - boolean
    doc: Dont make plots
    default: false
    inputBinding:
      position: 102
      prefix: --skip_plots
  - id: skip_secondary
    type:
      - 'null'
      - boolean
    doc: Skip secondary clustering, just perform MASH clustering
    default: false
    inputBinding:
      position: 102
      prefix: --SkipSecondary
  - id: strain_heterogeneity_weight
    type:
      - 'null'
      - float
    doc: strain heterogeneity weight
    default: 1
    inputBinding:
      position: 102
      prefix: --strain_heterogeneity_weight
  - id: warn_aln
    type:
      - 'null'
      - float
    doc: Minimum aligned fraction for warnings between dereplicated genomes 
      (ANIn)
    default: 0.25
    inputBinding:
      position: 102
      prefix: --warn_aln
  - id: warn_dist
    type:
      - 'null'
      - float
    doc: How far from the threshold to throw cluster warnings
    default: 0.25
    inputBinding:
      position: 102
      prefix: --warn_dist
  - id: warn_sim
    type:
      - 'null'
      - float
    doc: Similarity threshold for warnings between dereplicated genomes
    default: 0.98
    inputBinding:
      position: 102
      prefix: --warn_sim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drep:3.6.2--pyhdfd78af_0
stdout: drep_dRep dereplicate.out
