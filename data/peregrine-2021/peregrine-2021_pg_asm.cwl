cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_asm
label: peregrine-2021_pg_asm
doc: "Peregrine-2021 genome assembler: the main workflow entry for end-to-end assembly
  from the reads\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: input_reads
    type: File
    doc: Path to a file that contains the list of reads in .fa .fa.gz .fastq or fastq.gz
      formats
    inputBinding:
      position: 1
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 2
  - id: nchunks
    type:
      - 'null'
      - int
    doc: Number of partition
    inputBinding:
      position: 3
  - id: bestn
    type:
      - 'null'
      - int
    doc: number of best overlaps for initial graph
    default: 6
    inputBinding:
      position: 104
      prefix: --bestn
  - id: fast
    type:
      - 'null'
      - boolean
    doc: run the assembler in the fast mode
    inputBinding:
      position: 104
      prefix: --fast
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 104
      prefix: --keep
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size
    default: 56
    inputBinding:
      position: 104
      prefix: -k
  - id: layout_method
    type:
      - 'null'
      - int
    doc: layout version
    default: 2
    inputBinding:
      position: 104
      prefix: -l
  - id: log
    type:
      - 'null'
      - string
    doc: 'log level: DBBUG or INFO (default)'
    inputBinding:
      position: 104
      prefix: --log
  - id: min_ec_cov
    type:
      - 'null'
      - int
    doc: Minimum error coverage
    default: 1
    inputBinding:
      position: 104
      prefix: --min_ec_cov
  - id: no_resolve
    type:
      - 'null'
      - boolean
    doc: disable resolving repeats / dups at the end
    inputBinding:
      position: 104
      prefix: --no_resolve
  - id: reduction_factor
    type:
      - 'null'
      - int
    doc: Reduction factor
    default: 6
    inputBinding:
      position: 104
      prefix: -r
  - id: tol
    type:
      - 'null'
      - float
    doc: Alignment tolerance
    default: 0.01
    inputBinding:
      position: 104
      prefix: --tol
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    default: 80
    inputBinding:
      position: 104
      prefix: -w
outputs:
  - id: work_dir
    type: Directory
    doc: The path to a work directory for intermediate files and the results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
