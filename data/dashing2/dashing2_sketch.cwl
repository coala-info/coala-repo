cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing2
  - sketch
label: dashing2_sketch
doc: "Sketch only generates sketches, while cmp performs comparisons across inputs,
  but sketches if necessary.\n\nTool homepage: https://github.com/dnbaker/dashing2"
inputs:
  - id: fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files to sketch
    inputBinding:
      position: 1
  - id: bagminhash
    type:
      - 'null'
      - boolean
    doc: Enable WeightedSetSketch (Multiset sketching via BagMinHash).
    inputBinding:
      position: 102
      prefix: --bagminhash
  - id: bbit_sigs
    type:
      - 'null'
      - int
    doc: Truncate to bottom-<arg> bytes of signatures instead of 
      logarithmically-compressed.
    inputBinding:
      position: 102
      prefix: --bbit-sigs
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Sketch BED files for interval sets.
    inputBinding:
      position: 102
      prefix: --bed
  - id: bigwig
    type:
      - 'null'
      - boolean
    doc: Sketch BigWig files for coverage vectors.
    inputBinding:
      position: 102
      prefix: --bigwig
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Emit binary output rather than human-readable.
    inputBinding:
      position: 102
      prefix: --binary-output
  - id: cache_sketches
    type:
      - 'null'
      - boolean
    doc: Save sketches to disk instead of re-computing each time.
    inputBinding:
      position: 102
      prefix: --cache
  - id: compute_edit_distance
    type:
      - 'null'
      - boolean
    doc: For edit distance, perform actual edit distance calculations rather 
      than returning the distance in LSH space.
    inputBinding:
      position: 102
      prefix: --compute-edit-distance
  - id: containment
    type:
      - 'null'
      - boolean
    doc: Use containment as the distance. e.g., (|A & B| / |A|). This is 
      asymmetric.
    inputBinding:
      position: 102
      prefix: --containment
  - id: countdict
    type:
      - 'null'
      - boolean
    doc: Enable Full k-mer countdict. Generates a sorted hash set for k-mers and
      saves associated counts.
    inputBinding:
      position: 102
      prefix: --countdict
  - id: countmin_size
    type:
      - 'null'
      - int
    doc: Use a count-min sketch during sketching for weighted sketching with 
      fixed memory usage.
    inputBinding:
      position: 102
  - id: distance
    type:
      - 'null'
      - boolean
    doc: Emit distances, as estimated by the Poisson model for k-mer distances.
    inputBinding:
      position: 102
      prefix: --distance
  - id: downsample
    type:
      - 'null'
      - float
    doc: 'Downsample minimizers at fraction <arg>. Default is 1: IE, all minimizers
      pass.'
    inputBinding:
      position: 102
  - id: enable_protein
    type:
      - 'null'
      - boolean
    doc: Use 20 character amino acid alphabet.
    inputBinding:
      position: 102
      prefix: --enable-protein
  - id: entmin
    type:
      - 'null'
      - boolean
    doc: If -w/--window-size is enabled, this option weights the hash value by 
      the entropy of the k-mer itself.
    inputBinding:
      position: 102
  - id: fastcmp
    type:
      - 'null'
      - int
    doc: Enable faster comparisons using n-byte signatures rather than full 
      registers. <arg> may be 8 (64 bits), 4 (32 bits), 2 (16 bits), or 1 (8 
      bits).
    inputBinding:
      position: 102
      prefix: --fastcmp
  - id: fastcmp_bytes
    type:
      - 'null'
      - boolean
    doc: Sets a and b to 20 and 1.2, and sets --fastcmp to 1.
    inputBinding:
      position: 102
      prefix: --fastcmp-bytes
  - id: fastcmp_shorts
    type:
      - 'null'
      - boolean
    doc: Sets a and b to .06 and 1.0005, and sets --fastcmp to 2.
    inputBinding:
      position: 102
      prefix: --fastcmp-shorts
  - id: fastcmp_words
    type:
      - 'null'
      - boolean
    doc: Sets a and b to 19.77 and 1.0000000109723500835 and sets --fastcmp to 
      4.
    inputBinding:
      position: 102
      prefix: --fastcmp-words
  - id: ffile
    type:
      - 'null'
      - File
    doc: Read paths from file in addition to positional arguments.
    inputBinding:
      position: 102
      prefix: --ffile
  - id: filterset
    type:
      - 'null'
      - File
    doc: Skip k-mers in this file when sketching other files.
    inputBinding:
      position: 102
  - id: full_setsketch
    type:
      - 'null'
      - boolean
    doc: Enable FullSetSketch. Also treats inputs as sets but has better 
      behavior for larger sketches and small sets.
    inputBinding:
      position: 102
      prefix: --full
  - id: hp_compress
    type:
      - 'null'
      - boolean
    doc: Minimizer sequence will be homopolymer-compressed before emission.
    inputBinding:
      position: 102
      prefix: --hp-compress
  - id: intersection_size
    type:
      - 'null'
      - boolean
    doc: Emit the cardinality of the intersection between entities. IE, the 
      number of k-mers shared between the two.
    inputBinding:
      position: 102
      prefix: --intersection-size
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Set k-mer length. Defaults to the largest k expressible directly in 
      uint64_t.
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: leafcutter
    type:
      - 'null'
      - boolean
    doc: Sketch LeafCutter splicing output.
    inputBinding:
      position: 102
      prefix: --leafcutter
  - id: long_kmers
    type:
      - 'null'
      - boolean
    doc: Use 128-bit k-mer hashes instead of 64-bit.
    inputBinding:
      position: 102
      prefix: --long-kmers
  - id: mash_distance
    type:
      - 'null'
      - boolean
    doc: Emit distances, as estimated by the Poisson model for k-mer distances.
    inputBinding:
      position: 102
      prefix: --mash-distance
  - id: maxcand
    type:
      - 'null'
      - int
    doc: Set the maximum number of candidates to fetch from the LSH index before
      evaluating distances against them.
    inputBinding:
      position: 102
      prefix: --maxcand
  - id: multiset
    type:
      - 'null'
      - boolean
    doc: Enable WeightedSetSketch (Multiset sketching via BagMinHash).
    inputBinding:
      position: 102
      prefix: --multiset
  - id: nLSH
    type:
      - 'null'
      - int
    doc: Sets the number of LSH tables.
    default: 2
    inputBinding:
      position: 102
      prefix: --nlsh
  - id: no_canon
    type:
      - 'null'
      - boolean
    doc: Disable canonicalization. By default, DNA alphabet k-mers are 
      canonicalized to abstract strand. --no-canon causes Dashing2 to be 
      strand-specific.
    inputBinding:
      position: 102
      prefix: --no-canon
  - id: outprefix
    type:
      - 'null'
      - Directory
    doc: Specifies directory in which to save sketches instead of adjacent to 
      the input files.
    inputBinding:
      position: 102
      prefix: --outprefix
  - id: parse_by_seq
    type:
      - 'null'
      - boolean
    doc: Parse each sequence in each file as a separate entity.
    inputBinding:
      position: 102
      prefix: --parse-by-seq
  - id: pminhash
    type:
      - 'null'
      - boolean
    doc: Enable DiscreteProbabilitySetSketch (Discrete Probability Distributions
      using ProbMinHash).
    inputBinding:
      position: 102
      prefix: --pminhash
  - id: prob
    type:
      - 'null'
      - boolean
    doc: Enable DiscreteProbabilitySetSketch (Discrete Probability Distributions
      using ProbMinHash).
    inputBinding:
      position: 102
      prefix: --prob
  - id: protein14
    type:
      - 'null'
      - boolean
    doc: Use 14 character amino acid alphabet.
    inputBinding:
      position: 102
      prefix: --protein14
  - id: protein6
    type:
      - 'null'
      - boolean
    doc: Use 6 character amino acid alphabet.
    inputBinding:
      position: 102
      prefix: --protein6
  - id: protein8
    type:
      - 'null'
      - boolean
    doc: Use 8 character (3-bit) amino acid alphabet.
    inputBinding:
      position: 102
      prefix: --protein8
  - id: qfile
    type:
      - 'null'
      - File
    doc: Read query paths from file; this is used for asymmetric queries (e.g., 
      containment).
    inputBinding:
      position: 102
      prefix: --qfile
  - id: save_kmercounts
    type:
      - 'null'
      - boolean
    doc: Save k-mer counts for sketches. This puts the k-mer counts saved into 
      .kmercounts.f64 files to correspond with the k-mers.
    inputBinding:
      position: 102
      prefix: --save-kmercounts
  - id: save_kmers
    type:
      - 'null'
      - boolean
    doc: Save k-mers. This puts the k-mers saved into .kmer files to correspond 
      with the minhash samples.
    inputBinding:
      position: 102
      prefix: --save-kmers
  - id: seed
    type:
      - 'null'
      - int
    doc: Set a seed for k-mer hashing. If 0, this disables k-mer XORing and 
      k-mers are encoded directly if a k-mer type can represent it.
    inputBinding:
      position: 102
  - id: seq
    type:
      - 'null'
      - boolean
    doc: Enable Full k-mer (or minimizer) sequence. Faster than building the 
      hash set.
    inputBinding:
      position: 102
      prefix: --seq
  - id: seqs_in_ram
    type:
      - 'null'
      - boolean
    doc: For faster use but more memory (restoring previous behavior), add 
      --seqs-in-ram to avoid spilling to disk.
    inputBinding:
      position: 102
      prefix: --seqs-in-ram
  - id: set
    type:
      - 'null'
      - boolean
    doc: Enable K-mer Sets. Generates a sorted hash set for k-mers in the data.
    inputBinding:
      position: 102
      prefix: --set
  - id: setsketch_ab
    type:
      - 'null'
      - string
    doc: If you specify a, b before using this method, then SetSketches of 
      --fastcmp size bytes will be generated directly, rather than truncating 
      after sketching all items.
    inputBinding:
      position: 102
      prefix: --setsketch-ab
  - id: sketch_size_l2
    type:
      - 'null'
      - int
    doc: Set sketchsize to 2^<arg>. Must be > 0 and < 64.
    inputBinding:
      position: 102
      prefix: --sketch-size-l2
  - id: sketch_type
    type:
      - 'null'
      - string
    doc: 'Specifies the sketching mode. Options include: SetSketch (default), FullSetSketch,
      WeightedSetSketch, DiscreteProbabilitySetSketch, K-mer Sets (--set), Full k-mer
      countdict (--countdict), Full k-mer (or minimizer) sequence (--seq).'
    inputBinding:
      position: 102
  - id: sketchsize
    type:
      - 'null'
      - int
    doc: Set sketchsize.
    default: 1024
    inputBinding:
      position: 102
      prefix: --sketchsize
  - id: spacing
    type:
      - 'null'
      - string
    doc: Set a spacing scheme for spaced minimizers. Must have 1 less integer 
      than the k-mer length.
    inputBinding:
      position: 102
  - id: symmetric_containment
    type:
      - 'null'
      - boolean
    doc: Use symmetric containment as the distance. e.g., (|A & B| / min(|A|, 
      |B|)).
    inputBinding:
      position: 102
      prefix: --symmetric-containment
  - id: threads
    type:
      - 'null'
      - int
    doc: Threading parallelism is set with -p/--threads.
    inputBinding:
      position: 102
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Set a count threshold for inclusion. If set to > 1, this will only 
      sketch k-mers with count >= <arg>.
    inputBinding:
      position: 102
      prefix: --count-threshold
  - id: union_size
    type:
      - 'null'
      - boolean
    doc: Emit the cardinality of the union between entities. IE, the number of 
      k-mers in the union of the two.
    inputBinding:
      position: 102
      prefix: --union-size
  - id: window_size
    type:
      - 'null'
      - int
    doc: Set window size for winnowing; by default, all k-mers are used. If w > 
      k, then only the minimum-hash k-mer in each window is processed.
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Sketches are stacked into a single file and written to <arg>.
    outputBinding:
      glob: $(inputs.outfile)
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
