cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhap
label: mhap
doc: "MHAP: MinHash Alignment Protocol. Finds overlaps of long-read sequences (such as PacBio or Nanopore).\n\
  \nTool homepage: https://github.com/marbl/MHAP"
inputs:
  - id: from_file
    type:
      - 'null'
      - File
    doc: 'Usage 1: the FASTA or binary dat file of reads that will be stored in a box, and that all subsequent
      reads will be compared to.'
    inputBinding:
      position: 101
      prefix: -s
  - id: query_file
    type:
      - 'null'
      - File
    doc: 'Usage 1: the FASTA file of reads that will be compared to the set of reads in the box (-s).'
    inputBinding:
      position: 101
      prefix: -q
  - id: fasta_dir
    type:
      - 'null'
      - Directory
    doc: 'Usage 2: the directory containing FASTA files that should be converted to binary format for
      storage.'
    inputBinding:
      position: 101
      prefix: -p
  - id: binary_out_dir
    type:
      - 'null'
      - string
    doc: 'Usage 2: the output directory for the binary formatted dat files (-q).'
    inputBinding:
      position: 101
      prefix: -q
  - id: filter_file
    type:
      - 'null'
      - File
    doc: k-mer filter file used for filtering out highly repetitive k-mers. Must be sorted in descending
      order of frequency (second column).
    inputBinding:
      position: 101
      prefix: -f
  - id: filter_threshold
    type:
      - 'null'
      - float
    doc: The cutoff at which the k-mer in the k-mer filter file is considered repetitive (default 1.0E-5).
    inputBinding:
      position: 101
      prefix: --filter-threshold
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size used for MinHashing (default 16).
    inputBinding:
      position: 101
      prefix: -k
  - id: max_shift
    type:
      - 'null'
      - float
    doc: Region size to the left and right of the estimated overlap where k-mer matches are still considered
      valid (default 0.2).
    inputBinding:
      position: 101
      prefix: --max-shift
  - id: min_olap_length
    type:
      - 'null'
      - int
    doc: The minimum length of the read that is used for overlapping (default 116).
    inputBinding:
      position: 101
      prefix: --min-olap-length
  - id: min_store_length
    type:
      - 'null'
      - int
    doc: The minimum length of the read that is stored in the box (default 0).
    inputBinding:
      position: 101
      prefix: --min-store-length
  - id: no_rc
    type:
      - 'null'
      - boolean
    doc: Do not store or do comparison of the reverse complement strings.
    inputBinding:
      position: 101
      prefix: --no-rc
  - id: no_self
    type:
      - 'null'
      - boolean
    doc: Do not compute the overlaps between sequences inside a box.
    inputBinding:
      position: 101
      prefix: --no-self
  - id: no_tf
    type:
      - 'null'
      - boolean
    doc: Do not perform the tf weighing, in the tf-idf weighing.
    inputBinding:
      position: 101
      prefix: --no-tf
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: Number of min-mers to be used in MinHashing (default 512).
    inputBinding:
      position: 101
      prefix: --num-hashes
  - id: num_min_matches
    type:
      - 'null'
      - int
    doc: Minimum number of min-mers that must be shared before computing the second stage filter (default
      3).
    inputBinding:
      position: 101
      prefix: --num-min-matches
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation (default 20).
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: ordered_kmer_size
    type:
      - 'null'
      - int
    doc: The size of k-mers used in the ordered second stage filter (default 12).
    inputBinding:
      position: 101
      prefix: --ordered-kmer-size
  - id: ordered_sketch_size
    type:
      - 'null'
      - int
    doc: The sketch size for second stage filter (default 1536).
    inputBinding:
      position: 101
      prefix: --ordered-sketch-size
  - id: repeat_idf_scale
    type:
      - 'null'
      - float
    doc: The upper range of the idf scale (default 3.0).
    inputBinding:
      position: 101
      prefix: --repeat-idf-scale
  - id: repeat_weight
    type:
      - 'null'
      - float
    doc: Repeat suppression strength for tf-idf weighing (default 0.9).
    inputBinding:
      position: 101
      prefix: --repeat-weight
  - id: settings
    type:
      - 'null'
      - int
    doc: 'Set all unset parameters for the default settings: 0) None, 1) Default, 2) Fast, 3) Sensitive.'
    inputBinding:
      position: 101
      prefix: --settings
  - id: store_full_id
    type:
      - 'null'
      - boolean
    doc: Store full IDs as seen in FASTA files, rather than the sequence position in the file.
    inputBinding:
      position: 101
      prefix: --store-full-id
  - id: supress_noise
    type:
      - 'null'
      - int
    doc: 0) Does nothing, 1) removes any k-mers not specified in the filter file, 2) suppresses k-mers
      not specified in the filter file.
    inputBinding:
      position: 101
      prefix: --supress-noise
  - id: threshold
    type:
      - 'null'
      - float
    doc: The threshold cutoff for the second stage sort-merge filter (default 0.78).
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: overlaps
    type: stdout
    doc: Overlaps found, one per line (standard output).
  - id: binary_out
    type:
      - 'null'
      - Directory
    doc: 'Usage 2: directory with the binary formatted dat files.'
    outputBinding:
      glob: $(inputs.binary_out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.binary_out_dir ? {''class'': ''Directory'', ''basename'': inputs.binary_out_dir,
          ''listing'': []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhap:2.1.3--0
stdout: mhap.out
