cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - sketch_by_seq
label: dashing_sketch_by_seq
doc: "Produces k-mer/minimizer sketches from a set of sequences from a sequence file.\
  \ See cmp_by_seq for comparable distance calculation.\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: input_file
    type: File
    doc: Sequence file; each sequence record is sketched separately
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Write sketches to [file] and names to [file].names
    inputBinding:
      position: 102
      prefix: -o
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
    doc: Set log2 sketch size in bytes [10, for 2**10 bytes each]
    inputBinding:
      position: 102
      prefix: --sketch-size
  - id: no_canon
    type:
      - 'null'
      - boolean
    doc: 'Do not canonicalize. [Default: canonicalize]'
    inputBinding:
      position: 102
      prefix: --no-canon
  - id: bbits
    type:
      - 'null'
      - int
    doc: 'Set `b` for b-bit minwise hashing to <int>. Default: 16'
    inputBinding:
      position: 102
      prefix: --bbits
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads [1] (sketch_by_seq is not parallelized)
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: original
    type:
      - 'null'
      - boolean
    doc: 'Use Flajolet with inclusion/exclusion quantitation method for hll. [Default:
      Ertl MLE]'
    inputBinding:
      position: 102
      prefix: --original
  - id: improved
    type:
      - 'null'
      - boolean
    doc: 'Use Ertl Improved estimator [Default: Ertl MLE]'
    inputBinding:
      position: 102
      prefix: --improved
  - id: ertl_jmle
    type:
      - 'null'
      - boolean
    doc: Use Ertl JMLE
    inputBinding:
      position: 102
      prefix: --ertl-jmle
  - id: sketch_by_fname
    type:
      - 'null'
      - boolean
    doc: Autodetect fastq or fasta data by filename (.fq or .fastq within filename).
    inputBinding:
      position: 102
      prefix: --sketch-by-fname
  - id: countmin
    type:
      - 'null'
      - boolean
    doc: Filter all input data by count-min sketch.
    inputBinding:
      position: 102
      prefix: --countmin
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
  - id: min_count
    type:
      - 'null'
      - int
    doc: Provide minimum expected count for fastq data. If unspecified, all kmers
      are passed.
    inputBinding:
      position: 102
      prefix: --min-count
  - id: seed
    type:
      - 'null'
      - int
    doc: Set seed for seeds for count-min sketches
    inputBinding:
      position: 102
      prefix: --seed
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
  - id: defer_hll
    type:
      - 'null'
      - boolean
    doc: Maintain k-partition MinHash and produce an HLL at the end. May be faster
      (fewer instructions) or slower (more memory).
    inputBinding:
      position: 102
      prefix: --defer-hll
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sketch_output
    type: File
    doc: Sketches of all sequence records (gzip compressed)
    secondaryFiles:
      - .names
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_sketch_by_seq.out
