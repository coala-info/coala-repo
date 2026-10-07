cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - cmp
label: dashing_cmp
doc: "Compares sketches by options, including distance, similarity, and containment\
  \ (dist is an alias for cmp).\n\nTool homepage: https://github.com/dnbaker/dashing"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.listed_files ? inputs.listed_files : [])'
inputs:
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomes, read files or (with --presketched) sketch files; not needed when
      given with -F
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Set kmer size [31], max 32
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: spacing
    type:
      - 'null'
      - string
    doc: add a spacer of the format <int>x<int>,<int>x<int>,..., where the first integer
      corresponds to the space between bases repeated the second integer number of
      times
    inputBinding:
      position: 102
      prefix: --spacing
  - id: window_size
    type:
      - 'null'
      - int
    doc: Set window size [max(size of spaced kmer, [parameter])]
    inputBinding:
      position: 102
      prefix: --window-size
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Set sketch size [10, for 2**10 bytes each]
    inputBinding:
      position: 102
      prefix: --sketch-size
  - id: use_nthash
    type:
      - 'null'
      - boolean
    doc: Use nthash for encoding. (not reversible, but fast, rolling, and specialized
      for DNA). Allows k to be unbounded
    inputBinding:
      position: 102
      prefix: --use-nthash
  - id: use_cyclic_hash
    type:
      - 'null'
      - boolean
    doc: Uses a cyclic hash for encoding. Not reversible, but efficient. Allows k
      to be unbounded
    inputBinding:
      position: 102
      prefix: --use-cyclic-hash
  - id: no_canon
    type:
      - 'null'
      - boolean
    doc: 'Do not canonicalize. [Default: canonicalize]'
    inputBinding:
      position: 102
      prefix: --no-canon
  - id: out_sizes
    type:
      - 'null'
      - string
    doc: Output for genome size estimates [stdout]
    inputBinding:
      position: 102
      prefix: --out-sizes
  - id: out_dists
    type:
      - 'null'
      - string
    doc: Output for genome distance matrix [stdout]
    inputBinding:
      position: 102
      prefix: --out-dists
  - id: countmin
    type:
      - 'null'
      - boolean
    doc: Filter all input data by count-min sketch.
    inputBinding:
      position: 102
      prefix: --countmin
  - id: sketch_by_fname
    type:
      - 'null'
      - boolean
    doc: Autodetect fastq or fasta data by filename (.fq or .fastq within filename).
    inputBinding:
      position: 102
      prefix: --sketch-by-fname
  - id: min_count
    type:
      - 'null'
      - int
    doc: Set minimum count for kmers to pass count-min filtering.
    inputBinding:
      position: 102
      prefix: --min-count
  - id: nhashes
    type:
      - 'null'
      - int
    doc: 'Set count-min number of hashes. Default: [1]'
    inputBinding:
      position: 102
      prefix: --nhashes
  - id: cm_sketch_size
    type:
      - 'null'
      - int
    doc: 'Set count-min sketch size (log2). Default: 20'
    inputBinding:
      position: 102
      prefix: --cm-sketch-size
  - id: seed
    type:
      - 'null'
      - int
    doc: Set seed for seeds for count-min sketches
    inputBinding:
      position: 102
      prefix: --seed
  - id: paths_file
    type:
      - 'null'
      - File
    doc: Get paths to genomes from file rather than positional arguments (list the
      files by name and give them in listed_files)
    inputBinding:
      position: 102
      prefix: --paths
  - id: cache_sketches
    type:
      - 'null'
      - boolean
    doc: Cache sketches/use cached sketches
    inputBinding:
      position: 102
      prefix: --cache-sketches
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads [1]
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: query_paths
    type:
      - 'null'
      - File
    doc: Sets query paths to use for performing query against reference paths. Particularly
      for asymmetric distances or panel queries. For use only with option -F.
    inputBinding:
      position: 102
      prefix: --query-paths
  - id: nperbatch
    type:
      - 'null'
      - int
    doc: 'During pairwise distance computation, performance can be improved by batching
      sketch comparisons. Default: 16'
    inputBinding:
      position: 102
      prefix: --nperbatch
  - id: presketched
    type:
      - 'null'
      - boolean
    doc: Treat provided paths as pre-made sketches.
    inputBinding:
      position: 102
      prefix: --presketched
  - id: prefix
    type:
      - 'null'
      - string
    doc: Set prefix for sketch file locations [empty]
    inputBinding:
      position: 102
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: Set suffix in sketch file names [empty]
    inputBinding:
      position: 102
      prefix: --suffix
  - id: avoid_sorting
    type:
      - 'null'
      - boolean
    doc: Avoid sorting files by genome sizes. This avoids a computational step, but
      can result in degraded load-balancing.
    inputBinding:
      position: 102
      prefix: --avoid-sorting
  - id: emit_binary
    type:
      - 'null'
      - boolean
    doc: 'Emit distances in binary (float32) (default: human-readable, upper-triangular)'
    inputBinding:
      position: 102
      prefix: --emit-binary
  - id: phylip
    type:
      - 'null'
      - boolean
    doc: Emit distances in PHYLIP upper triangular format
    inputBinding:
      position: 102
      prefix: --phylip
  - id: full_tsv
    type:
      - 'null'
      - boolean
    doc: postprocess binary format to human-readable TSV (not upper triangular) [Square
      matrix]
    inputBinding:
      position: 102
      prefix: --full-tsv
  - id: emit_scientific
    type:
      - 'null'
      - boolean
    doc: Emit in scientific notation
    inputBinding:
      position: 102
      prefix: --emit-scientific
  - id: use_bb_minhash
    type:
      - 'null'
      - boolean
    doc: Create b-bit minhash sketches
    inputBinding:
      position: 102
      prefix: --use-bb-minhash
  - id: use_bloom_filter
    type:
      - 'null'
      - boolean
    doc: Create bloom filter sketches
    inputBinding:
      position: 102
      prefix: --use-bloom-filter
  - id: use_range_minhash
    type:
      - 'null'
      - boolean
    doc: Create range minhash sketches
    inputBinding:
      position: 102
      prefix: --use-range-minhash
  - id: use_full_khash_sets
    type:
      - 'null'
      - boolean
    doc: Use full khash sets for comparisons, rather than sketches. This can take
      a lot of memory and time!
    inputBinding:
      position: 102
      prefix: --use-full-khash-sets
  - id: improved
    type:
      - 'null'
      - boolean
    doc: Use Ertl's Improved Estimator for HLL
    inputBinding:
      position: 102
      prefix: --improved
  - id: original
    type:
      - 'null'
      - boolean
    doc: Use Ertl's Original Estimator for HLL
    inputBinding:
      position: 102
      prefix: --original
  - id: ertl_joint_mle
    type:
      - 'null'
      - boolean
    doc: Use Ertl's JMLE Estimator for HLL [default:Uses Ertl-MLE]
    inputBinding:
      position: 102
      prefix: --ertl-joint-mle
  - id: bbits
    type:
      - 'null'
      - int
    doc: 'Set `b` for b-bit minwise hashing to <int>. Default: 16. For HyperMinHash,
      this sets the full register size.'
    inputBinding:
      position: 102
      prefix: --bbits
  - id: mash_dist
    type:
      - 'null'
      - boolean
    doc: Emit Mash distance
    inputBinding:
      position: 102
      prefix: --mash-dist
  - id: full_mash_dist
    type:
      - 'null'
      - boolean
    doc: Emit full (not approximate) Mash distance.
    inputBinding:
      position: 102
      prefix: --full-mash-dist
  - id: sizes
    type:
      - 'null'
      - boolean
    doc: 'Emit intersection sizes (default: jaccard index)'
    inputBinding:
      position: 102
      prefix: --sizes
  - id: containment_index
    type:
      - 'null'
      - boolean
    doc: Emit Containment Index (|A & B| / |A|)
    inputBinding:
      position: 102
      prefix: --containment-index
  - id: containment_dist
    type:
      - 'null'
      - boolean
    doc: Emit distance metric using containment index.
    inputBinding:
      position: 102
      prefix: --containment-dist
  - id: symmetric_containment_dist
    type:
      - 'null'
      - boolean
    doc: Emit symmetric containment index symcon(A, B) = max(C(A, B), C(B, A))
    inputBinding:
      position: 102
      prefix: --symmetric-containment-dist
  - id: symmetric_containment_index
    type:
      - 'null'
      - boolean
    doc: Emit distance metric using maximum containment index. symdist(A, B) = min(cdist(A,B),
      cdist(B, A))
    inputBinding:
      position: 102
      prefix: --symmetric-containment-index
  - id: full_containment_dist
    type:
      - 'null'
      - boolean
    doc: Emit distance metric using containment index, without log approximation.
    inputBinding:
      position: 102
      prefix: --full-containment-dist
  - id: wj
    type:
      - 'null'
      - boolean
    doc: Enable weighted jaccard adapter using the count-min sketch
    inputBinding:
      position: 102
      prefix: --wj
  - id: wj_cm_sketch_size
    type:
      - 'null'
      - int
    doc: Set count-min sketch size for count-min streaming weighted jaccard [16]
    inputBinding:
      position: 102
      prefix: --wj-cm-sketch-size
  - id: wj_cm_nhashes
    type:
      - 'null'
      - int
    doc: Set count-min sketch number of hashes for count-min streaming weighted jaccard
      [8]
    inputBinding:
      position: 102
      prefix: --wj-cm-nhashes
  - id: defer_hll
    type:
      - 'null'
      - boolean
    doc: Maintain k-partition MinHash and produce an HLL at the end. May be faster
      (fewer instructions) or slower (more memory).
    inputBinding:
      position: 102
      prefix: --defer-hll
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in paths_file / query_paths; staged in the working folder so
      the names resolve
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sizes_output
    type:
      - 'null'
      - File
    doc: Genome size estimates
    outputBinding:
      glob: $(inputs.out_sizes)
  - id: dists_output
    type:
      - 'null'
      - File
    doc: Distance matrix (with a .labels file beside it in binary mode)
    secondaryFiles:
      - pattern: .labels
        required: false
    outputBinding:
      glob: $(inputs.out_dists)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_cmp.out
