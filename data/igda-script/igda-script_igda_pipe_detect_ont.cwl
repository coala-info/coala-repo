cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_detect_ont
label: igda-script_igda_pipe_detect_ont
doc: "Detects ONT reads using IGDA pipeline\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: infile
    type: File
    doc: Input BAM or SAM file
    inputBinding:
      position: 1
  - id: reffile
    type: File
    doc: Reference file
    inputBinding:
      position: 2
  - id: contextmodel
    type: File
    doc: Context model file
    inputBinding:
      position: 3
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 4
  - id: exclude_loci_file
    type:
      - 'null'
      - File
    doc: File with loci to exclude
    inputBinding:
      position: 105
      prefix: -x
  - id: isfast
    type:
      - 'null'
      - boolean
    doc: Flag to indicate fast mode
    default: true
    inputBinding:
      position: 105
      prefix: -f
  - id: min_condprob
    type:
      - 'null'
      - float
    doc: Minimum conditional probability
    default: 0.65
    inputBinding:
      position: 105
      prefix: -c
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum probability
    default: 0.2
    inputBinding:
      position: 105
      prefix: -p
  - id: min_readlen
    type:
      - 'null'
      - int
    doc: Minimum read length
    default: 1000
    inputBinding:
      position: 105
      prefix: -l
  - id: minimal_nreads_in_rsm
    type:
      - 'null'
      - int
    doc: Minimal number of reads in RSM
    default: 25
    inputBinding:
      position: 105
      prefix: -r
  - id: nthread
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 105
      prefix: -n
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed value
    default: 18473
    inputBinding:
      position: 105
      prefix: -s
  - id: topn_cmpreads
    type:
      - 'null'
      - int
    doc: Top N comparable reads
    default: 100
    inputBinding:
      position: 105
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_detect_ont.out
