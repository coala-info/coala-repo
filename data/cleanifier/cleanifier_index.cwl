cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cleanifier
  - index
label: cleanifier_index
doc: "build index of all species' FASTA/Q files\n\nTool homepage: https://gitlab.com/rahmannlab/cleanifier"
inputs:
  - id: cfg
    type:
      - 'null'
      - File
    doc: "Path to a configuration file."
    inputBinding:
      position: 101
      prefix: --cfg
  - id: index
    type: string
    doc: "name of the resulting index (.hash and .info output) (required)"
    inputBinding:
      position: 101
      prefix: --index
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTA/Q file(s) for the genomes that should be removed."
    inputBinding:
      position: 101
      prefix: --files
  - id: nobjects
    type: int
    doc: "number of k-mers to be stored in hash table (2_512_390_070 for human T2T and k=31) (required)"
    inputBinding:
      position: 101
      prefix: --nobjects
  - id: mask
    type:
      - 'null'
      - string
    doc: "gapped k-mer mask (quoted string like '#__##_##__#'); give --mask or --kmersize"
    inputBinding:
      position: 101
      prefix: --mask
  - id: kmersize
    type:
      - 'null'
      - int
    doc: "k-mer size; give --mask or --kmersize"
    inputBinding:
      position: 101
      prefix: --kmersize
  - id: bucketsize
    type:
      - 'null'
      - int
    doc: "bucket size, i.e. number of elements in a bucket (default: 4)"
    inputBinding:
      position: 101
      prefix: --bucketsize
  - id: fill
    type:
      - 'null'
      - float
    doc: "desired fill rate (< 1.0) of the hash table (default: 0.85)"
    inputBinding:
      position: 101
      prefix: --fill
  - id: subtables
    type:
      - 'null'
      - int
    doc: "number of subtables used; subtables+1 threads are used"
    inputBinding:
      position: 101
      prefix: --subtables
  - id: threads_read
    type:
      - 'null'
      - int
    doc: "Number of reader threads"
    inputBinding:
      position: 101
      prefix: --threads-read
  - id: threads_split
    type:
      - 'null'
      - int
    doc: "Number of splitter threads"
    inputBinding:
      position: 101
      prefix: --threads-split
  - id: shortcutbits
    type:
      - 'null'
      - int
    doc: "number of shortcut bits (0,1,2) (default: 0)"
    inputBinding:
      position: 101
      prefix: --shortcutbits
  - id: hashfunctions
    type:
      - 'null'
      - string
    doc: "hash functions: 'random', or 'func0:func1:func2:func3' (default: random)"
    inputBinding:
      position: 101
      prefix: --hashfunctions
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: "use power-of-two-bits-aligned buckets (slightly faster, but larger)"
    inputBinding:
      position: 101
      prefix: --aligned
  - id: statistics
    type:
      - 'null'
      - string
    doc: "level of detail for statistics (none, summary, details, full (all subtables)) (default: summary)"
    inputBinding:
      position: 101
      prefix: --statistics
  - id: maxwalk
    type:
      - 'null'
      - int
    doc: "maximum length of random walk through hash table before failing (default: 500)"
    inputBinding:
      position: 101
      prefix: --maxwalk
  - id: maxfailures
    type:
      - 'null'
      - int
    doc: "continue even after this many failures; forever: -1 (default: 0)"
    inputBinding:
      position: 101
      prefix: --maxfailures
  - id: walkseed
    type:
      - 'null'
      - int
    doc: "seed for random walks while inserting elements (default: 42)"
    inputBinding:
      position: 101
      prefix: --walkseed
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "use cuckoo filter instead of cuckoo hash table"
    inputBinding:
      position: 101
      prefix: --filter
  - id: fpr
    type:
      - 'null'
      - int
    doc: "integer k to build a cuckoo filter with an FPR of 1/2^k (only for --filter) (default: 14)"
    inputBinding:
      position: 101
      prefix: --fpr
  - id: windowsize
    type:
      - 'null'
      - int
    doc: "windowsize of cuckoo filter (only for --filter) (default: 2)"
    inputBinding:
      position: 101
      prefix: --windowsize
outputs:
  - id: index_hash
    type: File
    doc: "Index hash table (.hash)"
    outputBinding:
      glob: "$(inputs.index).hash"
  - id: index_info
    type: File
    doc: "Index information (.info)"
    outputBinding:
      glob: "$(inputs.index).info"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
stdout: cleanifier_index.out
