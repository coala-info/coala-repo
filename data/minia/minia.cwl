cwlVersion: v1.2
class: CommandLineTool
baseCommand: minia
label: minia
doc: "minia options\n\nTool homepage: https://github.com/GATB/minia"
inputs:
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: max abundance threshold for solid kmers
    default: 2147483647
    inputBinding:
      position: 101
      prefix: -abundance-max
  - id: abundance_min
    type:
      - 'null'
      - int
    doc: min abundance threshold for solid kmers
    default: 2
    inputBinding:
      position: 101
      prefix: -abundance-min
  - id: abundance_min_threshold
    type:
      - 'null'
      - int
    doc: min abundance hard threshold (only used when min abundance is "auto")
    default: 2
    inputBinding:
      position: 101
      prefix: -abundance-min-threshold
  - id: all_abundance_counts
    type:
      - 'null'
      - boolean
    doc: output all k-mer abundance counts instead of mean
    inputBinding:
      position: 101
      prefix: -all-abundance-counts
  - id: bloom
    type:
      - 'null'
      - string
    doc: bloom type ('basic', 'cache', 'neighbor')
    default: neighbor
    inputBinding:
      position: 101
      prefix: -bloom
  - id: branching_nodes
    type:
      - 'null'
      - string
    doc: branching type ('none' or 'stored')
    default: stored
    inputBinding:
      position: 101
      prefix: -branching-nodes
  - id: bulge_altpath_covmult
    type:
      - 'null'
      - float
    doc: bulges of coverage <= X*cov_altpath will be removed
    default: 1.1
    inputBinding:
      position: 101
      prefix: -bulge-altpath-covmult
  - id: bulge_altpath_kadd
    type:
      - 'null'
      - int
    doc: explore up to k+X nodes to find alternative path
    default: 50
    inputBinding:
      position: 101
      prefix: -bulge-altpath-kadd
  - id: bulge_len_kadd
    type:
      - 'null'
      - int
    doc: bulges shorter than k+X bp are candidate to be removed
    default: 100
    inputBinding:
      position: 101
      prefix: -bulge-len-kadd
  - id: bulge_len_kmult
    type:
      - 'null'
      - float
    doc: bulges shorter than k*X bp are candidate to be removed
    default: 3.0
    inputBinding:
      position: 101
      prefix: -bulge-len-kmult
  - id: config_only
    type:
      - 'null'
      - boolean
    doc: dump config only
    inputBinding:
      position: 101
      prefix: -config-only
  - id: debloom
    type:
      - 'null'
      - string
    doc: debloom type ('none', 'original' or 'cascading')
    default: cascading
    inputBinding:
      position: 101
      prefix: -debloom
  - id: debloom_impl
    type:
      - 'null'
      - string
    doc: debloom impl ('basic', 'minimizer')
    default: minimizer
    inputBinding:
      position: 101
      prefix: -debloom-impl
  - id: ec_len_kmult
    type:
      - 'null'
      - float
    doc: EC shorter than k*X bp are candidates to be removed
    default: 9.0
    inputBinding:
      position: 101
      prefix: -ec-len-kmult
  - id: ec_rctc_cutoff
    type:
      - 'null'
      - float
    doc: EC relative coverage coefficient (similar in spirit as tip)
    default: 4.0
    inputBinding:
      position: 101
      prefix: -ec-rctc-cutoff
  - id: edge_km
    type:
      - 'null'
      - int
    doc: edge km representation
    default: 0
    inputBinding:
      position: 101
      prefix: -edge-km
  - id: fasta_line
    type:
      - 'null'
      - int
    doc: number of nucleotides per line in fasta output (0 means one line)
    default: 0
    inputBinding:
      position: 101
      prefix: -fasta-line
  - id: histo
    type:
      - 'null'
      - boolean
    doc: output the kmer abundance histogram
    default: false
    inputBinding:
      position: 101
      prefix: -histo
  - id: histo2D
    type:
      - 'null'
      - boolean
    doc: compute the 2D histogram (with first file = genome, remaining files = 
      reads)
    default: false
    inputBinding:
      position: 101
      prefix: -histo2D
  - id: histo_max
    type:
      - 'null'
      - int
    doc: max number of values in kmers histogram
    default: 10000
    inputBinding:
      position: 101
      prefix: -histo-max
  - id: input
    type:
      - 'null'
      - File
    doc: input reads (fasta/fastq/compressed) or hdf5 file
    default: ''
    inputBinding:
      position: 101
      prefix: -in
  - id: integer_precision
    type:
      - 'null'
      - int
    doc: integers precision (0 for optimized value)
    default: 0
    inputBinding:
      position: 101
      prefix: -integer-precision
  - id: keep_isolated
    type:
      - 'null'
      - boolean
    doc: keep short (<= max(2k, 150 bp)) isolated output sequences
    inputBinding:
      position: 101
      prefix: -keep-isolated
  - id: kff
    type:
      - 'null'
      - boolean
    doc: also output kmers in kff format
    inputBinding:
      position: 101
      prefix: -kff
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a kmer
    default: 31
    inputBinding:
      position: 101
      prefix: -kmer-size
  - id: max_disk
    type:
      - 'null'
      - int
    doc: max disk   (in MBytes)
    default: 0
    inputBinding:
      position: 101
      prefix: -max-disk
  - id: max_memory
    type:
      - 'null'
      - int
    doc: max memory (in MBytes)
    default: 5000
    inputBinding:
      position: 101
      prefix: -max-memory
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of a minimizer
    default: 10
    inputBinding:
      position: 101
      prefix: -minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq)
    default: 0
    inputBinding:
      position: 101
      prefix: -minimizer-type
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    default: 0
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: nb_glue_partitions
    type:
      - 'null'
      - int
    doc: number of glue partitions (automatically calculated by default)
    default: 0
    inputBinding:
      position: 101
      prefix: -nb-glue-partitions
  - id: no_bulge_removal
    type:
      - 'null'
      - boolean
    doc: ask to not perform bulge removal
    inputBinding:
      position: 101
      prefix: -no-bulge-removal
  - id: no_ec_removal
    type:
      - 'null'
      - boolean
    doc: ask to not perform erroneous connection removal
    inputBinding:
      position: 101
      prefix: -no-ec-removal
  - id: no_mphf
    type:
      - 'null'
      - boolean
    doc: don't construct the MPHF
    inputBinding:
      position: 101
      prefix: -no-mphf
  - id: no_tip_removal
    type:
      - 'null'
      - boolean
    doc: ask to not perform tip removal
    inputBinding:
      position: 101
      prefix: -no-tip-removal
  - id: out_compress
    type:
      - 'null'
      - int
    doc: h5 compression level (0:none, 9:best)
    default: 0
    inputBinding:
      position: 101
      prefix: -out-compress
  - id: redo_bcalm
    type:
      - 'null'
      - boolean
    doc: debug function, redo the bcalm algo
    inputBinding:
      position: 101
      prefix: -redo-bcalm
  - id: redo_bglue
    type:
      - 'null'
      - boolean
    doc: same, but       redo     bglue (needs debug_keep_glue_files=true in 
      source code)
    inputBinding:
      position: 101
      prefix: -redo-bglue
  - id: redo_links
    type:
      - 'null'
      - boolean
    doc: same, but       redo     links
    inputBinding:
      position: 101
      prefix: -redo-links
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered)
    default: 0
    inputBinding:
      position: 101
      prefix: -repartition-type
  - id: skip_bcalm
    type:
      - 'null'
      - boolean
    doc: same, but       skip     bcalm
    inputBinding:
      position: 101
      prefix: -skip-bcalm
  - id: skip_bglue
    type:
      - 'null'
      - boolean
    doc: same, but       skip     bglue
    inputBinding:
      position: 101
      prefix: -skip-bglue
  - id: skip_links
    type:
      - 'null'
      - boolean
    doc: same, but       skip     links
    inputBinding:
      position: 101
      prefix: -skip-links
  - id: solidity_custom
    type:
      - 'null'
      - string
    doc: when solidity-kind is custom, specifies list of files where kmer must 
      be present
    default: ''
    inputBinding:
      position: 101
      prefix: -solidity-custom
  - id: solidity_kind
    type:
      - 'null'
      - string
    doc: way to compute counts of several files (sum, min, max, one, all, 
      custom)
    default: sum
    inputBinding:
      position: 101
      prefix: -solidity-kind
  - id: storage_type
    type:
      - 'null'
      - string
    doc: storage type of kmer counts ('hdf5' or 'file')
    default: hdf5
    inputBinding:
      position: 101
      prefix: -storage-type
  - id: tip_len_rctc_kmult
    type:
      - 'null'
      - float
    doc: remove tips that pass coverage criteria, of length <= k * X bp
    default: 10.0
    inputBinding:
      position: 101
      prefix: -tip-len-rctc-kmult
  - id: tip_len_topo_kmult
    type:
      - 'null'
      - float
    doc: remove all tips of length <= k * X bp
    default: 2.5
    inputBinding:
      position: 101
      prefix: -tip-len-topo-kmult
  - id: tip_rctc_cutoff
    type:
      - 'null'
      - float
    doc: 'tip relative coverage coefficient: mean coverage of neighbors >  X * tip
      coverage'
    default: 2.0
    inputBinding:
      position: 101
      prefix: -tip-rctc-cutoff
  - id: topology_stats
    type:
      - 'null'
      - int
    doc: topological information level (0 for none)
    default: 0
    inputBinding:
      position: 101
      prefix: -topology-stats
  - id: traversal
    type:
      - 'null'
      - string
    doc: traversal type ('contig', 'unitig')
    default: contig
    inputBinding:
      position: 101
      prefix: -traversal
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 1
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: solid_kmers_out
    type:
      - 'null'
      - File
    doc: output file for solid kmers (only when constructing a graph)
    outputBinding:
      glob: $(inputs.solid_kmers_out)
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out_dir)
  - id: out_tmp
    type:
      - 'null'
      - Directory
    doc: output directory for temporary files
    outputBinding:
      glob: $(inputs.out_tmp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minia:3.2.6--h22625ea_5
