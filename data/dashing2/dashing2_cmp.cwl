cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing2
  - cmp
label: dashing2_cmp
doc: "Performs comparisons across inputs, but sketches if necessary.\n\nTool homepage:
  https://github.com/dnbaker/dashing2"
inputs:
  - id: opts
    type:
      - 'null'
      - string
    doc: Options for the command
    inputBinding:
      position: 1
  - id: fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files (optional)
    inputBinding:
      position: 2
  - id: asymmetric_all_pairs
    type:
      - 'null'
      - boolean
    doc: Square distance matrix comparison.
    inputBinding:
      position: 103
      prefix: --asymmetric-all-pairs
  - id: bbit_sigs
    type:
      - 'null'
      - int
    doc: Truncate to bottom-<arg> bytes of signatures instead of 
      logarithmically-compressed.
    inputBinding:
      position: 103
      prefix: --bbit-sigs
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Emit binary output rather than human-readable.
    inputBinding:
      position: 103
      prefix: --binary-output
  - id: cache_sketches
    type:
      - 'null'
      - boolean
    doc: Save sketches to disk instead of re-computing each time.
    inputBinding:
      position: 103
      prefix: --cache/--cache-sketches
  - id: compute_edit_distance
    type:
      - 'null'
      - boolean
    doc: For edit distance, perform actual edit distance calculations rather 
      than returning the distance in LSH space.
    inputBinding:
      position: 103
      prefix: --compute-edit-distance
  - id: containment
    type:
      - 'null'
      - boolean
    doc: Use containment as the distance. e.g., (|A & B| / |A|). This is 
      asymmetric, so you must consider that when deciding the output shape.
    inputBinding:
      position: 103
      prefix: --containment
  - id: countdict
    type:
      - 'null'
      - boolean
    doc: Enable Full k-mer countdict. Generates a sorted hash set for k-mers in 
      the data, and additionally saves the associated counts for these k-mers.
    inputBinding:
      position: 103
      prefix: --countdict
  - id: countmin_size
    type:
      - 'null'
      - int
    doc: Enabled by --countmin-size [number-registers], this allows for weighted
      sketching with fixed memory usage at the expense of some approximation. 
      This is only relevant to WeightedSetSketch and 
      DiscreteProbabilitySetSketch.
    inputBinding:
      position: 103
      prefix: --countmin-size
  - id: downsample
    type:
      - 'null'
      - float
    doc: 'Downsample minimizers at fraction <arg>. Default is 1: IE, all minimizers
      pass.'
    inputBinding:
      position: 103
      prefix: --downsample
  - id: enable_protein
    type:
      - 'null'
      - boolean
    doc: Use 20 character amino acid alphabet. This will disable 
      canonicalization.
    inputBinding:
      position: 103
      prefix: --enable-protein
  - id: entmin
    type:
      - 'null'
      - boolean
    doc: If -w/--window-size is enabled, this option weights the hash value by 
      the entropy of the k-mer itself. This is only valid for k-mers short 
      enough to be encoded exactly in 64-bit or 128-bit integers, depending on 
      if --long-kmers is enabled.
    inputBinding:
      position: 103
      prefix: --entmin
  - id: fastcmp
    type:
      - 'null'
      - int
    doc: Enable faster comparisons using n-byte signatures rather than full 
      registers. By default, these are logarithmically-compressed. <arg> may be 
      8 (64 bits), 4 (32 bits), 2 (16 bits), or 1 (8 bits).
    inputBinding:
      position: 103
      prefix: --fastcmp/--regsize
  - id: fastcmp_bytes
    type:
      - 'null'
      - boolean
    doc: Sets a and b to 20 and 1.2, and sets --fastcmp to 1.
    inputBinding:
      position: 103
      prefix: --fastcmp-bytes
  - id: fastcmp_shorts
    type:
      - 'null'
      - boolean
    doc: Sets a and b to .06 and 1.0005, and sets --fastcmp to 2.
    inputBinding:
      position: 103
      prefix: --fastcmp-shorts
  - id: fastcmp_words
    type:
      - 'null'
      - boolean
    doc: Sets a and b to 19.77 and 1.0000000109723500835 and sets --fastcmp to 
      4.
    inputBinding:
      position: 103
      prefix: --fastcmp-words
  - id: ffile
    type:
      - 'null'
      - File
    doc: Read paths from file in addition to positional arguments.
    inputBinding:
      position: 103
      prefix: --ffile
  - id: filterset
    type:
      - 'null'
      - File
    doc: Skip k-mers in this file when sketching other files.
    inputBinding:
      position: 103
      prefix: --filterset
  - id: full_setsketch
    type:
      - 'null'
      - boolean
    doc: Enable FullSetSketch. Also treats inputs as sets but has better 
      behavior for larger sketches and small sets.
    inputBinding:
      position: 103
      prefix: --full/--full-setsketch
  - id: greedy
    type:
      - 'null'
      - float
    doc: For greedy clustering by a given similarity threshold. This uses an LSH
      index by default.
    inputBinding:
      position: 103
      prefix: --greedy
  - id: hp_compress
    type:
      - 'null'
      - boolean
    doc: Minimizer sequence will be homopolymer-compressed before emission. This
      makes the sequences ignore the lengths of minimizer stretches.
    inputBinding:
      position: 103
      prefix: --hp-compress
  - id: intersection_size
    type:
      - 'null'
      - boolean
    doc: Emit the cardinality of the intersection between entities. IE, the 
      number of k-mers shared between the two.
    inputBinding:
      position: 103
      prefix: --intersection-size/--intersection
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Set k-mer length. Defaults to the largest k expressible directly in 
      uint64_t.
    inputBinding:
      position: 103
      prefix: --kmer-length
  - id: long_kmers
    type:
      - 'null'
      - boolean
    doc: Use 128-bit k-mer hashes instead of 64-bit.
    inputBinding:
      position: 103
      prefix: --128bit/long-kmers
  - id: mash_distance
    type:
      - 'null'
      - boolean
    doc: Emit distances, as estimated by the Poisson model for k-mer distances.
    inputBinding:
      position: 103
      prefix: --mash-distance/--poisson-distance/--distance
  - id: maxcand
    type:
      - 'null'
      - int
    doc: Set the maximum number of candidates to fetch from the LSH index before
      evaluating distances against them. This is always used in --greedy mode.
    inputBinding:
      position: 103
      prefix: --maxcand
  - id: multiset
    type:
      - 'null'
      - boolean
    doc: 'Enable WeightedSetSketch: Weighted Sets sketched by BagMinHash.'
    inputBinding:
      position: 103
      prefix: --multiset/--bagminhash
  - id: nlsh
    type:
      - 'null'
      - int
    doc: This sets the number of LSH tables. The first 3 tables use register 
      grouping sizes of powers of 2, and subsequent tables use 2 times the 
      index.
    inputBinding:
      position: 103
      prefix: --nlsh
  - id: no_canon
    type:
      - 'null'
      - boolean
    doc: If DNA is being encoded, this disables canonicalization. By default, 
      DNA sequence is canonicalized with its reverse-complement. Otherwise, this
      is ignored.
    inputBinding:
      position: 103
      prefix: --no-canon
  - id: outfile
    type:
      - 'null'
      - File
    doc: Sketches are stacked into a single file and written to <arg>. This is 
      the path for the stacked sketches; to set output location, use --cmpout 
      instead.
    inputBinding:
      position: 103
      prefix: --outfile
  - id: outprefix
    type:
      - 'null'
      - Directory
    doc: Specifies directory in which to save sketches instead of adjacent to 
      the input files.
    inputBinding:
      position: 103
      prefix: --outprefix
  - id: parse_by_seq
    type:
      - 'null'
      - boolean
    doc: Parse each sequence in each file as a separate entity.
    inputBinding:
      position: 103
      prefix: --parse-by-seq
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Alias for --outprefix.
    inputBinding:
      position: 103
      prefix: --prefix
  - id: presketched
    type:
      - 'null'
      - boolean
    doc: To compute distances using a pre-sketched method (e.g., dashing2 sketch
      -o path), use this flag and pass in a single positional argument.
    inputBinding:
      position: 103
      prefix: --presketched
  - id: prob
    type:
      - 'null'
      - boolean
    doc: 'Enable DiscreteProbabilitySetSketch: Discrete Probability Distributions
      using ProbMinHash.'
    inputBinding:
      position: 103
      prefix: --prob/--pminhash
  - id: protein14
    type:
      - 'null'
      - boolean
    doc: Use 14 character amino acid alphabet. This will disable 
      canonicalization.
    inputBinding:
      position: 103
      prefix: --protein14
  - id: protein6
    type:
      - 'null'
      - boolean
    doc: Use 6 character amino acid alphabet. This will disable 
      canonicalization.
    inputBinding:
      position: 103
      prefix: --protein6
  - id: protein8
    type:
      - 'null'
      - boolean
    doc: Use 8 character amino acid alphabet. This will disable 
      canonicalization.
    inputBinding:
      position: 103
      prefix: --protein8
  - id: qfile
    type:
      - 'null'
      - File
    doc: Read query paths from file; this is used for asymmetric queries (e.g., 
      containment).
    inputBinding:
      position: 103
      prefix: --qfile
  - id: save_kmercounts
    type:
      - 'null'
      - boolean
    doc: Save k-mer counts for sketches. This puts the k-mer counts saved into 
      .kmercounts.f64 files to correspond with the k-mers.
    inputBinding:
      position: 103
      prefix: --save-kmercounts
  - id: save_kmers
    type:
      - 'null'
      - boolean
    doc: Save k-mers. This puts the k-mers saved into .kmer files to correspond 
      with the minhash samples.
    inputBinding:
      position: 103
      prefix: --save-kmers
  - id: seed
    type:
      - 'null'
      - int
    doc: Set a seed for k-mer hashing; If 0, this disables k-mer XORing and 
      k-mers are encoded directly if a k-mer type can represent it. Otherwise, 
      this changes the hash function applied to k-mers when generated sorted 
      hash sets.
    inputBinding:
      position: 103
      prefix: --seed
  - id: seq
    type:
      - 'null'
      - boolean
    doc: Enable Full k-mer (or minimizer) sequence. This faster than building 
      the hash set, and can be used to build a minimizer index afterwards.
    inputBinding:
      position: 103
      prefix: --seq
  - id: seqs_in_ram
    type:
      - 'null'
      - boolean
    doc: For faster use but more memory (restoring previous behavior), add 
      --seqs-in-ram to avoid spilling to disk.
    inputBinding:
      position: 103
      prefix: --seqs-in-ram
  - id: set
    type:
      - 'null'
      - boolean
    doc: Enable K-mer Sets. Generates a sorted hash set for k-mers in the data.
    inputBinding:
      position: 103
      prefix: --set
  - id: setsketch_ab
    type:
      - 'null'
      - string
    doc: If you specify a, b before using this method, then SetSketches of 
      --fastcmp size bytes will be generated directly, rather than truncating 
      after sketching all items.
    inputBinding:
      position: 103
      prefix: --setsketch-ab
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: Minimum fraction similarity for inclusion. If this is enabled, only 
      pairwise similarities over <arg> will be emitted.
    inputBinding:
      position: 103
      prefix: --similarity-threshold
  - id: sketch_size_l2
    type:
      - 'null'
      - int
    doc: Set sketchsize to 2^<arg>. Must be > 0 and < 64.
    inputBinding:
      position: 103
      prefix: --sketch-size-l2
  - id: sketchsize
    type:
      - 'null'
      - int
    doc: Set sketchsize.
    inputBinding:
      position: 103
      prefix: --sketchsize
  - id: spacing
    type:
      - 'null'
      - string
    doc: Set a spacing scheme for spaced minimizers. This must have 1 less 
      integer than the k-mer length.
    inputBinding:
      position: 103
      prefix: --spacing
  - id: square
    type:
      - 'null'
      - boolean
    doc: Square distance matrix comparison.
    inputBinding:
      position: 103
      prefix: --square
  - id: symmetric_containment
    type:
      - 'null'
      - boolean
    doc: Use symmetric containment as the distance. e.g., (|A & B| / min(|A|, 
      |B|)).
    inputBinding:
      position: 103
      prefix: --symmetric-containment
  - id: threads
    type:
      - 'null'
      - int
    doc: Threading parallelism
    inputBinding:
      position: 103
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Set a count threshold for inclusion. If set to > 1, this will only 
      sketch k-mers with count >= <arg>
    inputBinding:
      position: 103
      prefix: --threshold/--count-threshold
  - id: topk
    type:
      - 'null'
      - int
    doc: Maximum number of nearest neighbors to list. If <arg> is greater than N
      - 1, pairwise distances are instead emitted.
    inputBinding:
      position: 103
      prefix: --topk/--top-k
  - id: union_size
    type:
      - 'null'
      - boolean
    doc: Emit the cardinality of the union between entities. IE, the number of 
      k-mers in the union of the two.
    inputBinding:
      position: 103
      prefix: --union-size
  - id: window_size
    type:
      - 'null'
      - int
    doc: Set window size for winnowing; by default, all k-mers are used. If w > 
      k, then only the minimum-hash k-mer in each window is processed.
    inputBinding:
      position: 103
      prefix: --window-size
outputs:
  - id: cmpout
    type:
      - 'null'
      - File
    doc: Compute distances and emit them to <arg>.
    outputBinding:
      glob: $(inputs.cmpout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing2:2.1.20--he9e5f93_0
