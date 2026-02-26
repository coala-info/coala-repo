cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketch
label: dashing_sketch
doc: "Sketching genomes with sketch: 0/HLL/HyperLogLog\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomes if not provided from a file with -F
    inputBinding:
      position: 1
  - id: avoid_sorting
    type:
      - 'null'
      - boolean
    doc: Avoid sorting files by genome sizes. This avoids a computational step, 
      but can result in degraded load-balancing.
    inputBinding:
      position: 102
      prefix: --avoid-sorting
  - id: bbits
    type:
      - 'null'
      - int
    doc: 'Set `b` for b-bit minwise hashing to <int>. Default: 16'
    inputBinding:
      position: 102
      prefix: --bbits
  - id: cm_sketch_size
    type:
      - 'null'
      - int
    doc: 'Set count-min sketch size (log2). Default: 20'
    default: 20
    inputBinding:
      position: 102
      prefix: --cm-sketch-size
  - id: countmin
    type:
      - 'null'
      - boolean
    doc: Filter all input data by count-min sketch.
    inputBinding:
      position: 102
      prefix: --countmin
  - id: defer_hll
    type:
      - 'null'
      - boolean
    doc: Maintain k-partition MinHash and produce an HLL at the end. May be 
      faster (fewer instructions) or slower (more memory).
    inputBinding:
      position: 102
      prefix: --defer-hll
  - id: ertl_jmle
    type:
      - 'null'
      - boolean
    doc: Use Ertl JMLE
    inputBinding:
      position: 102
      prefix: --ertl-jmle
  - id: improved
    type:
      - 'null'
      - boolean
    doc: 'Use Ertl Improved estimator [Default: Ertl MLE]'
    inputBinding:
      position: 102
      prefix: --improved
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Set kmer size [31], max 32
    default: 31
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: min_count
    type:
      - 'null'
      - int
    doc: Provide minimum expected count for fastq data. If unspecified, all 
      kmers are passed.
    inputBinding:
      position: 102
      prefix: --min-count
  - id: nhashes
    type:
      - 'null'
      - int
    doc: 'Set count-min number of hashes. Default: [1]'
    default: 1
    inputBinding:
      position: 102
      prefix: --nhashes
  - id: no_canon
    type:
      - 'null'
      - boolean
    doc: 'Do not canonicalize. [Default: canonicalize]'
    inputBinding:
      position: 102
      prefix: --no-canon
  - id: original
    type:
      - 'null'
      - boolean
    doc: 'Use Flajolet with inclusion/exclusion quantitation method for hll. [Default:
      Ertl MLE]'
    inputBinding:
      position: 102
      prefix: --original
  - id: paths_file
    type:
      - 'null'
      - File
    doc: Get paths to genomes from file rather than positional arguments
    inputBinding:
      position: 102
      prefix: --paths
  - id: prefix
    type:
      - 'null'
      - string
    doc: Set prefix for sketch file locations [empty]
    default: ''
    inputBinding:
      position: 102
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: Set seed for seeds for count-min sketches
    inputBinding:
      position: 102
      prefix: --seed
  - id: sketch_by_fname
    type:
      - 'null'
      - boolean
    doc: Autodetect fastq or fasta data by filename (.fq or .fastq within 
      filename).
    inputBinding:
      position: 102
      prefix: --sketch-by-fname
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Set log2 sketch size in bytes [10, for 2**10 bytes each]
    default: 10
    inputBinding:
      position: 102
      prefix: --sketch-size
  - id: skip_cached
    type:
      - 'null'
      - boolean
    doc: Skip alreday produced/cached sketches (save sketches to disk in 
      directory of the file [default] or in folder specified by -P
    inputBinding:
      position: 102
      prefix: --skip-cached
  - id: spacing
    type:
      - 'null'
      - string
    doc: add a spacer of the format <int>x<int>,<int>x<int>,..., where the first
      integer corresponds to the space between bases repeated the second integer
      number of times
    inputBinding:
      position: 102
      prefix: --spacing
  - id: suffix
    type:
      - 'null'
      - string
    doc: Set suffix in sketch file names [empty]
    default: ''
    inputBinding:
      position: 102
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads [1]
    default: 1
    inputBinding:
      position: 102
      prefix: --nthreads
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
  - id: use_full_hash_sets
    type:
      - 'null'
      - boolean
    doc: Use full khash sets for comparisons, rather than sketches. This can 
      take a lot of memory and time!
    inputBinding:
      position: 102
      prefix: --use-full-hash-sets
  - id: use_full_khash_sets
    type:
      - 'null'
      - boolean
    doc: Use full khash sets for comparisons, rather than sketches. This can 
      take a lot of memory and time!
    inputBinding:
      position: 102
      prefix: --use-full-khash-sets
  - id: use_hash_sets
    type:
      - 'null'
      - boolean
    doc: Use full khash sets for comparisons, rather than sketches. This can 
      take a lot of memory and time!
    inputBinding:
      position: 102
      prefix: --use-hash-sets
  - id: use_range_minhash
    type:
      - 'null'
      - boolean
    doc: Create range minhash sketches
    inputBinding:
      position: 102
      prefix: --use-range-minhash
  - id: window_size
    type:
      - 'null'
      - int
    doc: Set window size [max(size of spaced kmer, [parameter])]
    inputBinding:
      position: 102
      prefix: --window-size
  - id: wj
    type:
      - 'null'
      - boolean
    doc: Enable weighted jaccard adapter using the count-min sketch
    inputBinding:
      position: 102
      prefix: --wj
  - id: wj_cm_nhashes
    type:
      - 'null'
      - int
    doc: Set count-min sketch number of hashes for count-min streaming weighted 
      jaccard [8]
    default: 8
    inputBinding:
      position: 102
      prefix: --wj-cm-nhashes
  - id: wj_cm_sketch_size
    type:
      - 'null'
      - int
    doc: Set count-min sketch size for count-min streaming weighted jaccard [16]
    default: 16
    inputBinding:
      position: 102
      prefix: --wj-cm-sketch-size
  - id: wj_exact
    type:
      - 'null'
      - boolean
    doc: Enable exact weighted jaccard using a hash map
    inputBinding:
      position: 102
      prefix: --wj-exact
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_sketch.out
