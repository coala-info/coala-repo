cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dRep
  - compare
label: drep_dRep compare
doc: "Compare genomes to find similar ones\n\nTool homepage: https://github.com/MrOlm/drep"
inputs:
  - id: work_directory
    type: Directory
    doc: Directory where data and output are stored *** USE THE SAME WORK 
      DIRECTORY FOR ALL DREP OPERATIONS ***
    inputBinding:
      position: 1
  - id: clusterAlg
    type:
      - 'null'
      - string
    doc: Algorithm used to cluster genomes (passed to 
      scipy.cluster.hierarchy.linkage
    inputBinding:
      position: 102
      prefix: --clusterAlg
  - id: cov_thresh
    type:
      - 'null'
      - float
    doc: Minmum level of overlap between genomes when doing secondary 
      comparisons
    inputBinding:
      position: 102
      prefix: --cov_thresh
  - id: coverage_method
    type:
      - 'null'
      - string
    doc: Method to calculate coverage of an alignment (for ANIn/ANImf only; gANI
      and fastANI can only do larger method) total   = 2*(aligned length) / (sum
      of total genome lengths) larger  = max((aligned length / genome 1), 
      (aligned_length / genome2))
    inputBinding:
      position: 102
      prefix: --coverage_method
  - id: debug
    type:
      - 'null'
      - boolean
    doc: make extra debugging output
    inputBinding:
      position: 102
      prefix: --debug
  - id: gen_warnings
    type:
      - 'null'
      - boolean
    doc: Generate warnings
    inputBinding:
      position: 102
      prefix: --gen_warnings
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
    inputBinding:
      position: 102
      prefix: --greedy_secondary_clustering
  - id: low_ram_primary_clustering
    type:
      - 'null'
      - boolean
    doc: Use a memory-efficient algorithm for primary clustering. This only 
      affects primary clustering and not secondary clustering.
    inputBinding:
      position: 102
      prefix: --low_ram_primary_clustering
  - id: mash_sketch
    type:
      - 'null'
      - int
    doc: MASH sketch size
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
    inputBinding:
      position: 102
      prefix: --multiround_primary_clustering
  - id: n_preset
    type:
      - 'null'
      - string
    doc: Presets to pass to nucmer tight   = only align highly conserved regions
      normal  = default ANIn parameters
    inputBinding:
      position: 102
      prefix: --n_PRESET
  - id: p_ani
    type:
      - 'null'
      - float
    doc: ANI threshold to form primary (MASH) clusters
    inputBinding:
      position: 102
      prefix: --P_ani
  - id: primary_chunksize
    type:
      - 'null'
      - int
    doc: Impacts multiround_primary_clustering. If you have more than this many 
      genomes, process them in chunks of this size.
    inputBinding:
      position: 102
      prefix: --primary_chunksize
  - id: processors
    type:
      - 'null'
      - int
    doc: threads
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
    inputBinding:
      position: 102
      prefix: --S_algorithm
  - id: s_ani
    type:
      - 'null'
      - float
    doc: ANI threshold to form secondary clusters
    inputBinding:
      position: 102
      prefix: --S_ani
  - id: skani_extra
    type:
      - 'null'
      - string
    doc: Extra arguments to pass to skani triangle
    inputBinding:
      position: 102
      prefix: --skani_extra
  - id: skip_mash
    type:
      - 'null'
      - boolean
    doc: Skip MASH clustering, just do secondary clustering on all genomes
    inputBinding:
      position: 102
      prefix: --SkipMash
  - id: skip_secondary
    type:
      - 'null'
      - boolean
    doc: Skip secondary clustering, just perform MASH clustering
    inputBinding:
      position: 102
      prefix: --SkipSecondary
  - id: warn_aln
    type:
      - 'null'
      - float
    doc: Minimum aligned fraction for warnings between dereplicated genomes 
      (ANIn)
    inputBinding:
      position: 102
      prefix: --warn_aln
  - id: warn_dist
    type:
      - 'null'
      - float
    doc: How far from the threshold to throw cluster warnings
    inputBinding:
      position: 102
      prefix: --warn_dist
  - id: warn_sim
    type:
      - 'null'
      - float
    doc: Similarity threshold for warnings between dereplicated genomes
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
stdout: drep_dRep compare.out
