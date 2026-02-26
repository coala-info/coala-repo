cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hulk
  - sketch
label: hulk_sketch
doc: "Create a sketch from a set of reads. The sketch subcommand can be used to create
  a histosketch, minhash or count min sketch.\n\nTool homepage: https://github.com/will-rowe/hulk"
inputs:
  - id: banner_label
    type:
      - 'null'
      - string
    doc: adds a label to the sketch object, for use with BANNER
    default: blank
    inputBinding:
      position: 101
      prefix: --bannerLabel
  - id: decay_ratio
    type:
      - 'null'
      - float
    doc: decay ratio used for concept drift (1.0 = concept drift disabled)
    default: 1.0
    inputBinding:
      position: 101
      prefix: --decayRatio
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: tells HULK that the input file is actually FASTA format 
      (.fna/.fasta/.fa), not FASTQ (experimental feature)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) to sketch (can also pipe in STDIN)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: interval
    type:
      - 'null'
      - int
    doc: size of k-mer sampling interval (default 0 (= no interval))
    default: 0
    inputBinding:
      position: 101
      prefix: --interval
  - id: khf
    type:
      - 'null'
      - boolean
    doc: also generate a MinHash K-Hash Functions sketch
    inputBinding:
      position: 101
      prefix: --khf
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: minimizer k-mer length
    default: 21
    inputBinding:
      position: 101
      prefix: --kmerSize
  - id: kmv
    type:
      - 'null'
      - boolean
    doc: also generate a MinHash K-Minimum Values (bottom-k) sketch
    inputBinding:
      position: 101
      prefix: --kmv
  - id: processors
    type:
      - 'null'
      - int
    doc: number of processors to use
    default: 1
    inputBinding:
      position: 101
      prefix: --processors
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: create the files needed to profile HULK using the go tool pprof
    inputBinding:
      position: 101
      prefix: --profiling
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: size of sketch
    default: 50
    inputBinding:
      position: 101
      prefix: --sketchSize
  - id: stream
    type:
      - 'null'
      - boolean
    doc: prints the sketches to STDOUT after every interval is reached, whilst 
      still writting them to disk (log file is redirected to disk))
    inputBinding:
      position: 101
      prefix: --stream
  - id: window_size
    type:
      - 'null'
      - int
    doc: minimizer window size
    default: 9
    inputBinding:
      position: 101
      prefix: --windowSize
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: filename for log file, if omitted then STDOUT used by default
    outputBinding:
      glob: $(inputs.log)
  - id: out_file
    type:
      - 'null'
      - File
    doc: directory and basename for saving the outfile(s)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hulk:1.0.0--h375a9b1_0
