cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bbnorm.sh
label: bbmap_bbnorm
doc: "Normalizes read depth based on kmer counts. Can also error-correct, bin reads
  by kmer depth, and generate a kmer depth histogram.\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: bits_per_cell
    type:
      - 'null'
      - int
    doc: Bits per cell in bloom filter; must be 2, 4, 8, 16, or 32.
    inputBinding:
      position: 101
      prefix: bits
  - id: build_passes
    type:
      - 'null'
      - int
    doc: More passes can sometimes increase accuracy by iteratively removing low-depth
      kmers
    inputBinding:
      position: 101
      prefix: buildpasses
  - id: error_correction
    type:
      - 'null'
      - boolean
    doc: Set to true to correct errors.
    inputBinding:
      position: 101
      prefix: ecc
  - id: exit_on_oom
    type:
      - 'null'
      - boolean
    doc: This flag will cause the process to exit if an out-of-memory exception occurs.
    inputBinding:
      position: 101
      prefix: -eoom
  - id: extra_input
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional files to use for input (generating hash table) but not for output
    inputBinding:
      position: 101
      prefix: extra
  - id: fasta_read_length
    type:
      - 'null'
      - int
    doc: Break up FASTA reads longer than this
    inputBinding:
      position: 101
      prefix: fastareadlen
  - id: hashes
    type:
      - 'null'
      - int
    doc: Number of times each kmer is hashed and stored.
    inputBinding:
      position: 101
      prefix: hashes
  - id: input_file
    type: File
    doc: Primary input. Use in2 for paired reads in a second file
    inputBinding:
      position: 101
      prefix: in
  - id: input_file_2
    type:
      - 'null'
      - File
    doc: Second input file for paired reads in two files
    inputBinding:
      position: 101
      prefix: in2
  - id: interleaved
    type:
      - 'null'
      - string
    doc: May be set to true or false to force the input read file to override autodetection
      of the input file as paired interleaved.
    inputBinding:
      position: 101
      prefix: interleaved
  - id: java_memory
    type:
      - 'null'
      - string
    doc: This will set Java's memory usage, overriding autodetection (e.g., -Xmx20g).
    inputBinding:
      position: 101
      prefix: -Xmx
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Set to true to keep all reads (e.g. if you just want error correction).
    inputBinding:
      position: 101
      prefix: keepall
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer length
    inputBinding:
      position: 101
      prefix: k
  - id: kmer_sample
    type:
      - 'null'
      - int
    doc: Process every nth kmer, and skip the rest
    inputBinding:
      position: 101
      prefix: kmersample
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Reads will not be downsampled when below this depth
    inputBinding:
      position: 101
      prefix: maxdepth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Kmers with depth below this number will not be included when calculating
      the depth of a read.
    inputBinding:
      position: 101
      prefix: mindepth
  - id: min_good_kmers
    type:
      - 'null'
      - int
    doc: Reads must have at least this many kmers over min depth to be retained.
    inputBinding:
      position: 101
      prefix: minkmers
  - id: min_probability
    type:
      - 'null'
      - float
    doc: Ignore kmers with overall probability of correctness below this
    inputBinding:
      position: 101
      prefix: minprob
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Ignore kmers containing bases with quality below this
    inputBinding:
      position: 101
      prefix: minq
  - id: passes
    type:
      - 'null'
      - int
    doc: 1 pass is the basic mode. 2 passes (default) allows greater accuracy.
    inputBinding:
      position: 101
      prefix: passes
  - id: percentile
    type:
      - 'null'
      - float
    doc: Read depth is by default inferred from the 54th percentile of kmer depth
    inputBinding:
      position: 101
      prefix: percentile
  - id: prefilter
    type:
      - 'null'
      - boolean
    doc: Filters out low-depth kmers from the main hashtable.
    inputBinding:
      position: 101
      prefix: prefilter
  - id: prefilter_bits
    type:
      - 'null'
      - int
    doc: Bits per cell in prefilter.
    inputBinding:
      position: 101
      prefix: prefilterbits
  - id: prefilter_size
    type:
      - 'null'
      - float
    doc: Fraction of memory to allocate to prefilter.
    inputBinding:
      position: 101
      prefix: prefiltersize
  - id: prehashes
    type:
      - 'null'
      - int
    doc: Number of hashes for prefilter.
    inputBinding:
      position: 101
      prefix: prehashes
  - id: quality_in
    type:
      - 'null'
      - string
    doc: ASCII offset for input quality. May be 33 (Sanger), 64 (Illumina), or auto.
    inputBinding:
      position: 101
      prefix: qin
  - id: quality_out
    type:
      - 'null'
      - string
    doc: ASCII offset for output quality. May be 33 (Sanger), 64 (Illumina), or auto.
    inputBinding:
      position: 101
      prefix: qout
  - id: read_sample
    type:
      - 'null'
      - int
    doc: Process every nth read, and skip the rest
    inputBinding:
      position: 101
      prefix: readsample
  - id: reads_to_process
    type:
      - 'null'
      - int
    doc: Only process this number of reads, then quit (-1 means all)
    inputBinding:
      position: 101
      prefix: reads
  - id: remove_duplicate_kmers
    type:
      - 'null'
      - boolean
    doc: When true, a kmer's count will only be incremented once per read pair
    inputBinding:
      position: 101
      prefix: rdk
  - id: rename
    type:
      - 'null'
      - boolean
    doc: Rename reads based on their kmer depth.
    inputBinding:
      position: 101
      prefix: rename
  - id: sample_output
    type:
      - 'null'
      - boolean
    doc: Use sampling on output as well as input
    inputBinding:
      position: 101
      prefix: sampleoutput
  - id: table_reads
    type:
      - 'null'
      - int
    doc: Use at most this many reads when building the hashtable (-1 means all)
    inputBinding:
      position: 101
      prefix: tablereads
  - id: target_depth
    type:
      - 'null'
      - int
    doc: Target normalization depth.
    inputBinding:
      position: 101
      prefix: target
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: This will specify a directory for temp files (only needed for multipass runs).
    inputBinding:
      position: 101
      prefix: tmpdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Spawn exactly X hashing threads
    inputBinding:
      position: 101
      prefix: threads
  - id: use_temp_directory
    type:
      - 'null'
      - boolean
    doc: Allows enabling/disabling of temporary directory
    inputBinding:
      position: 101
      prefix: usetempdir
  - id: zero_bin
    type:
      - 'null'
      - boolean
    doc: Set to true if you want kmers with a count of 0 to go in the 0 bin instead
      of the 1 bin in histograms.
    inputBinding:
      position: 101
      prefix: zerobin
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File for normalized or corrected reads. Use out2 for paired reads in a second
      file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_toss
    type:
      - 'null'
      - File
    doc: File for reads that were excluded from primary output
    outputBinding:
      glob: $(inputs.output_toss)
  - id: histogram_input
    type:
      - 'null'
      - File
    doc: Specify a file to write the input kmer depth histogram.
    outputBinding:
      glob: $(inputs.histogram_input)
  - id: histogram_output
    type:
      - 'null'
      - File
    doc: Specify a file to write the output kmer depth histogram.
    outputBinding:
      glob: $(inputs.histogram_output)
  - id: peaks_file
    type:
      - 'null'
      - File
    doc: Write the peaks to this file. Default is stdout.
    outputBinding:
      glob: $(inputs.peaks_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
