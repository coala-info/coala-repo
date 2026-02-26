cwlVersion: v1.2
class: CommandLineTool
baseCommand: abruijn
label: abruijn
doc: "ABruijn: assembly of long and error-prone reads\n\nTool homepage: https://github.com/fenderglass/ABruijn/"
inputs:
  - id: reads
    type: File
    doc: path to reads file (FASTA format)
    inputBinding:
      position: 1
  - id: coverage
    type: int
    doc: estimated assembly coverage
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable debug output
    inputBinding:
      position: 103
      prefix: --debug
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of polishing iterations
    default: 1
    inputBinding:
      position: 103
      prefix: --iterations
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'kmer size (default: auto)'
    inputBinding:
      position: 103
      prefix: --kmer-size
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: 'maximum kmer coverage (default: auto)'
    inputBinding:
      position: 103
      prefix: --max-coverage
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'minimum kmer coverage (default: auto)'
    inputBinding:
      position: 103
      prefix: --min-coverage
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum overlap between reads
    default: 5000
    inputBinding:
      position: 103
      prefix: --min-overlap
  - id: platform
    type:
      - 'null'
      - string
    doc: sequencing platform (pacbio, nano, pacbio_hi_err)
    default: pacbio
    inputBinding:
      position: 103
      prefix: --platform
  - id: resume
    type:
      - 'null'
      - boolean
    doc: try to resume previous assembly
    inputBinding:
      position: 103
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abruijn:2.1b--py27_0
