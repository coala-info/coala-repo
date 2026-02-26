cwlVersion: v1.2
class: CommandLineTool
baseCommand: hackgap count
label: hackgap_count
doc: "Count k-mers in specified files.\n\nTool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs:
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: use power-of-two aligned buckets (faster, but larger)
    inputBinding:
      position: 101
      prefix: --aligned
  - id: bucketsize
    type:
      - 'null'
      - int
    doc: bucket size, i.e. number of elements on a bucket
    inputBinding:
      position: 101
      prefix: --bucketsize
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: file(s) in which to count k-mers ([gzipped] FASTA or FASTQ)
    inputBinding:
      position: 101
      prefix: --files
  - id: fill
    type:
      - 'null'
      - float
    doc: desired fill rate of the hash table
    inputBinding:
      position: 101
      prefix: --fill
  - id: filterfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: optionally, different file(s) to populate filters ([gzipped] FASTA or 
      FASTQ); the default and typical use case is to use the same files as for 
      counting, so usually, you do not want to use this option.
    inputBinding:
      position: 101
      prefix: --filterfiles
  - id: filtersizes
    type:
      - 'null'
      - type: array
        items: string
    doc: size of filter(s) in gigabytes, up to 3 filter levels. For counting 
      without filtering, do not specify this option.
    inputBinding:
      position: 101
      prefix: --filtersizes
  - id: hashfunctions
    type:
      - 'null'
      - string
    doc: "hash functions: 'default', 'random', or func0:func1:func2:func3"
    inputBinding:
      position: 101
      prefix: --hashfunctions
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: --kmersize
  - id: markweak
    type:
      - 'null'
      - boolean
    doc: mark weak vs. strong k-mers after counting (slow)
    inputBinding:
      position: 101
      prefix: --markweak
  - id: mask
    type: string
    doc: gapped k-mer mask (quoted string like '#__##_##__#')
    inputBinding:
      position: 101
      prefix: --mask
  - id: maxcount
    type:
      - 'null'
      - int
    doc: maximum count value [65535]; should be 2**N - 1 for some N
    default: 65535
    inputBinding:
      position: 101
      prefix: --maxcount
  - id: maxfailures
    type:
      - 'null'
      - int
    doc: continue even after this many failures [default:0; forever:-1]
    default: 0
    inputBinding:
      position: 101
      prefix: --maxfailures
  - id: maxwalk
    type:
      - 'null'
      - int
    doc: maximum length of random walk through hash table before failing [500]
    default: 500
    inputBinding:
      position: 101
      prefix: --maxwalk
  - id: nobjects
    type: int
    doc: number of objects to be stored
    inputBinding:
      position: 101
      prefix: --nobjects
  - id: rcmode
    type:
      - 'null'
      - string
    doc: mode specifying how to encode k-mers
    inputBinding:
      position: 101
      prefix: --rcmode
  - id: statistics
    type:
      - 'null'
      - string
    doc: statistics level of detail (none, *summary*, details, full (all 
      subtables))
    default: summary
    inputBinding:
      position: 101
      prefix: --statistics
  - id: subtables
    type:
      - 'null'
      - int
    doc: number of subtables used; subtables+1 threads are used
    inputBinding:
      position: 101
      prefix: --subtables
  - id: threads_read
    type:
      - 'null'
      - int
    doc: number of reader threads
    inputBinding:
      position: 101
      prefix: --threads-read
  - id: threads_split
    type:
      - 'null'
      - int
    doc: number of splitter threads
    inputBinding:
      position: 101
      prefix: --threads-split
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: use unaligned buckets (smaller, slightly slower; default)
    inputBinding:
      position: 101
      prefix: --unaligned
  - id: walkseed
    type:
      - 'null'
      - int
    doc: seed for random walks while inserting elements [7]
    default: 7
    inputBinding:
      position: 101
      prefix: --walkseed
outputs:
  - id: output_prefix
    type: File
    doc: path/prefix of output file with k-mer count hash (required; use 
      '/dev/null' or 'null' or 'none' to avoid output)
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
