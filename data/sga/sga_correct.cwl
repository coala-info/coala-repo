cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - correct
label: sga_correct
doc: "Correct sequencing errors in all the reads in READSFILE\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: readsfile
    type: File
    doc: Input file containing reads
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: specify the correction algorithm to use. STR must be one of kmer, 
      hybrid, overlap.
    default: kmer
    inputBinding:
      position: 102
      prefix: --algorithm
  - id: base_threshold
    type:
      - 'null'
      - int
    doc: Attempt to correct bases in a read that are seen less than N times
    default: 2
    inputBinding:
      position: 102
      prefix: --base-threshold
  - id: branch_cutoff
    type:
      - 'null'
      - int
    doc: stop the overlap search at N branches. This parameter is used to 
      control the search time for highly-repetitive reads. If the number of 
      branches exceeds N, the search stops and the read will not be corrected. 
      This is not enabled by default.
    inputBinding:
      position: 102
      prefix: --branch-cutoff
  - id: conflict
    type:
      - 'null'
      - int
    doc: use INT as the threshold to detect a conflicted base in the 
      multi-overlap
    default: 5
    inputBinding:
      position: 102
      prefix: --conflict
  - id: count_offset
    type:
      - 'null'
      - int
    doc: When correcting a kmer, require the count of the new kmer is at least 
      +N higher than the count of the old kmer.
    default: 1
    inputBinding:
      position: 102
      prefix: --count-offset
  - id: discard
    type:
      - 'null'
      - boolean
    doc: detect and discard low-quality reads
    inputBinding:
      position: 102
      prefix: --discard
  - id: error_rate
    type:
      - 'null'
      - float
    doc: the maximum error rate allowed between two sequences to consider them 
      overlapped
    default: 0.04
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: kmer_rounds
    type:
      - 'null'
      - int
    doc: Perform N rounds of k-mer correction, correcting up to N bases
    default: 10
    inputBinding:
      position: 102
      prefix: --kmer-rounds
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The length of the kmer to use.
    default: 31
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: kmer_threshold
    type:
      - 'null'
      - int
    doc: Attempt to correct kmers that are seen less than N times.
    default: 3
    inputBinding:
      position: 102
      prefix: --kmer-threshold
  - id: learn
    type:
      - 'null'
      - boolean
    doc: Attempt to learn the k-mer correction threshold (experimental). 
      Overrides -x parameter.
    inputBinding:
      position: 102
      prefix: --learn
  - id: metrics
    type:
      - 'null'
      - File
    doc: collect error correction metrics (error rate by position in read, etc) 
      and write them to FILE
    inputBinding:
      position: 102
      prefix: --metrics
  - id: min_count_max_base
    type:
      - 'null'
      - int
    doc: minimum count of the base that has the highest count in overlap 
      correction. The base of the read is only corrected if the maximum base has
      at least this count. Should avoid mis-corrections in low coverage regions
    default: 4
    inputBinding:
      position: 102
      prefix: --min-count-max-base
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum overlap required between two reads
    default: 45
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: prefix
    type:
      - 'null'
      - string
    doc: use PREFIX for the names of the index files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: rounds
    type:
      - 'null'
      - int
    doc: iteratively correct reads up to a maximum of NUM rounds
    default: 1
    inputBinding:
      position: 102
      prefix: --rounds
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: use occurrence array sample rate of N in the FM-index. Higher values 
      use significantly less memory at the cost of higher runtime. This value 
      must be a power of 2
    default: 128
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: seed_length
    type:
      - 'null'
      - int
    doc: force the seed length to be LEN. By default, the seed length in the 
      overlap step is calculated to guarantee all overlaps with --error-rate 
      differences are found. This option removes the guarantee but will be 
      (much) faster. As SGA can tolerate some missing edges, this option may be 
      preferable for some data sets.
    inputBinding:
      position: 102
      prefix: --seed-length
  - id: seed_stride
    type:
      - 'null'
      - int
    doc: force the seed stride to be LEN. This parameter will be ignored unless 
      --seed-length is specified (see above). This parameter defaults to the 
      same value as --seed-length
    inputBinding:
      position: 102
      prefix: --seed-stride
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads for the computation
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write the corrected reads to FILE
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
