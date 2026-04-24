cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploflow
label: haploflow
doc: "HaploFlow parameters\n\nTool homepage: https://github.com/hzi-bifo/Haploflow"
inputs:
  - id: create_dump
    type:
      - 'null'
      - boolean
    doc: 'create dump of the deBruijn graph. WARNING: This file may be huge'
    inputBinding:
      position: 101
      prefix: --create-dump
  - id: debug
    type:
      - 'null'
      - int
    doc: Report all temporary graphs and coverage histograms
    inputBinding:
      position: 101
      prefix: --debug
  - id: dump_file
    type:
      - 'null'
      - File
    doc: deBruijn graph dump file produced by HaploFlow
    inputBinding:
      position: 101
      prefix: --dump-file
  - id: error_rate
    type:
      - 'null'
      - float
    doc: percentage filter for erroneous kmers - kmers appearing less than 
      relatively e% will be ignored
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: filter
    type:
      - 'null'
      - int
    doc: filter contigs shorter than value
    inputBinding:
      position: 101
      prefix: --filter
  - id: from_dump
    type:
      - 'null'
      - boolean
    doc: run from a Haploflow dump of the deBruijn graph.
    inputBinding:
      position: 101
      prefix: --from-dump
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer size, default 41, please use an odd number
    inputBinding:
      position: 101
      prefix: --k
  - id: log
    type:
      - 'null'
      - string
    doc: 'log file (default: standard out)'
    inputBinding:
      position: 101
      prefix: --log
  - id: long
    type:
      - 'null'
      - int
    doc: Try to maximise contig lengths (might introduce errors)
    inputBinding:
      position: 101
      prefix: --long
  - id: read_file
    type:
      - 'null'
      - File
    doc: read file (fastq)
    inputBinding:
      position: 101
      prefix: --read-file
  - id: strict
    type:
      - 'null'
      - int
    doc: more strict error correction, should be set to 5 in first run on new 
      data set to reduce run time. Set to 0 if low abundant strains are expected
      to be present
    inputBinding:
      position: 101
      prefix: --strict
  - id: thresh
    type:
      - 'null'
      - int
    doc: Provide a custom threshold for complex/bad data
    inputBinding:
      position: 101
      prefix: --thresh
  - id: true_flow
    type:
      - 'null'
      - int
    doc: Do not perform flow correction, assume perfect flows
    inputBinding:
      position: 101
      prefix: --true-flow
  - id: two_strain
    type:
      - 'null'
      - int
    doc: mode for known two-strain mixtures
    inputBinding:
      position: 101
      prefix: --two-strain
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: 'folder for output, will be created if not present. WARNING: Old results
      will get overwritten'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploflow:1.0--h9948957_5
