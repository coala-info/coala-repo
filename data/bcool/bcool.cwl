cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcool
label: bcool
doc: "De Bruijn graph based read corrector\n\nTool homepage: https://github.com/Malfoy/BCOOL"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print command lines
    inputBinding:
      position: 101
      prefix: -d
  - id: ksize
    type:
      - 'null'
      - string
    doc: k-mer size
    default: AUTO
    inputBinding:
      position: 101
      prefix: -k
  - id: maximum_occurence
    type:
      - 'null'
      - int
    doc: Maximum occurence of an anchor, better correction for repetitive genome
      but slower
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: min_cov
    type:
      - 'null'
      - int
    doc: k-mers present strictly less than this number of times in the dataset 
      will be discarded
    default: 2
    inputBinding:
      position: 101
      prefix: -s
  - id: missmatch_allowed
    type:
      - 'null'
      - int
    doc: Maximum number of corrected bases
    default: 10
    inputBinding:
      position: 101
      prefix: -m
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: Number of cores used
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path to store the results
    default: current directory
    inputBinding:
      position: 101
      prefix: -o
  - id: single_readfiles
    type: File
    doc: input fasta read files. Several read files must be concatenated
    inputBinding:
      position: 101
      prefix: -u
  - id: subsample_anchor
    type:
      - 'null'
      - int
    doc: index one out of i anchors to reduce memory consumption
    default: 1
    inputBinding:
      position: 101
      prefix: -i
  - id: unitig_coverage
    type:
      - 'null'
      - string
    doc: Unitig Coverage for cleaning
    default: AUTO
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcool:1.0.0--py35_0
stdout: bcool.out
