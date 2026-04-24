cwlVersion: v1.2
class: CommandLineTool
baseCommand: groot align
label: groot_align
doc: "Sketch sequences, align to references and weight variation graphs\n\nTool homepage:
  https://github.com/will-rowe/groot"
inputs:
  - id: contig_threshold
    type:
      - 'null'
      - float
    doc: containment threshold for the LSH ensemble
    inputBinding:
      position: 101
      prefix: --contThresh
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: if set, the input will be treated as fasta sequence(s) (experimental 
      feature)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) to align
    inputBinding:
      position: 101
      prefix: --fastq
  - id: graph_directory
    type:
      - 'null'
      - Directory
    doc: directory to save variation graphs to
    inputBinding:
      position: 101
      prefix: --graphDir
  - id: index_directory
    type:
      - 'null'
      - Directory
    doc: directory for to write/read the GROOT index files
    inputBinding:
      position: 101
      prefix: --indexDir
  - id: log_file
    type:
      - 'null'
      - File
    doc: filename for log file
    inputBinding:
      position: 101
      prefix: --log
  - id: min_kmer_coverage
    type:
      - 'null'
      - float
    doc: minimum number of k-mers covering each base of a graph segment
    inputBinding:
      position: 101
      prefix: --minKmerCov
  - id: no_alignment
    type:
      - 'null'
      - boolean
    doc: if set, no exact alignment will be performed - graphs will be weighted 
      using approximate read mappings
    inputBinding:
      position: 101
      prefix: --noAlign
  - id: processors
    type:
      - 'null'
      - int
    doc: number of processors to use
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
stdout: groot_align.out
