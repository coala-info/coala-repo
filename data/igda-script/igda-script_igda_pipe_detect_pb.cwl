cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_detect_pb
label: igda-script_igda_pipe_detect_pb
doc: "Detects potential structural variations in sequencing data.\n\nTool homepage:
  https://github.com/zhixingfeng/shell"
inputs:
  - id: infile
    type: File
    doc: Input BAM or SAM file.
    inputBinding:
      position: 1
  - id: reffile
    type: File
    doc: Reference file.
    inputBinding:
      position: 2
  - id: contextmodel
    type: string
    doc: Context model.
    inputBinding:
      position: 3
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for processing.
    inputBinding:
      position: 104
      prefix: -b
  - id: distance
    type:
      - 'null'
      - int
    doc: Distance parameter.
    inputBinding:
      position: 104
      prefix: -d
  - id: exclude_loci_file
    type:
      - 'null'
      - File
    doc: File containing loci to exclude.
    inputBinding:
      position: 104
      prefix: -x
  - id: is_fast
    type:
      - 'null'
      - int
    doc: Flag to enable fast mode.
    inputBinding:
      position: 104
      prefix: -f
  - id: min_condprob
    type:
      - 'null'
      - float
    doc: Minimum conditional probability.
    inputBinding:
      position: 104
      prefix: -c
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum probability.
    inputBinding:
      position: 104
      prefix: -p
  - id: min_readlen
    type:
      - 'null'
      - int
    doc: Minimum read length.
    inputBinding:
      position: 104
      prefix: -l
  - id: minimal_nreads_in_rsm
    type:
      - 'null'
      - int
    doc: Minimal number of reads in RSM.
    inputBinding:
      position: 104
      prefix: -r
  - id: nthread
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 104
      prefix: -n
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generation.
    inputBinding:
      position: 104
      prefix: -s
  - id: topn_cmpreads
    type:
      - 'null'
      - int
    doc: Top N comparable reads.
    inputBinding:
      position: 104
      prefix: -q
outputs:
  - id: outdir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
