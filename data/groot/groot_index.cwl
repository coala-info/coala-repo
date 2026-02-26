cwlVersion: v1.2
class: CommandLineTool
baseCommand: groot index
label: groot_index
doc: "Convert a set of clustered reference sequences to variation graphs and then
  index them\n\nTool homepage: https://github.com/will-rowe/groot"
inputs:
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of k-mer
    default: 31
    inputBinding:
      position: 101
      prefix: --kmerSize
  - id: log_file
    type:
      - 'null'
      - File
    doc: filename for log file
    default: groot.log
    inputBinding:
      position: 101
      prefix: --log
  - id: max_k
    type:
      - 'null'
      - int
    doc: maxK in the LSH Ensemble
    default: 4
    inputBinding:
      position: 101
      prefix: --maxK
  - id: max_sketch_span
    type:
      - 'null'
      - int
    doc: max number of identical neighbouring sketches permitted in any graph 
      traversal
    default: 30
    inputBinding:
      position: 101
      prefix: --maxSketchSpan
  - id: msa_dir
    type: Directory
    doc: directory containing the clustered references (MSA files) - required
    inputBinding:
      position: 101
      prefix: --msaDir
  - id: num_partitions
    type:
      - 'null'
      - int
    doc: number of partitions in the LSH Ensemble
    default: 8
    inputBinding:
      position: 101
      prefix: --numPart
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
    doc: create the files needed to profile GROOT using the go tool pprof
    inputBinding:
      position: 101
      prefix: --profiling
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: size of MinHash sketch
    default: 21
    inputBinding:
      position: 101
      prefix: --sketchSize
  - id: window_size
    type:
      - 'null'
      - int
    doc: size of window to sketch graph traversals with
    default: 100
    inputBinding:
      position: 101
      prefix: --windowSize
outputs:
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: directory for to write/read the GROOT index files
    outputBinding:
      glob: $(inputs.index_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
