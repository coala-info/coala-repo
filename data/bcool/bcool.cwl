cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcool
label: bcool
doc: "De Bruijn graph based read corrector\n\nTool homepage: https://github.com/Malfoy/BCOOL"
inputs:
  - id: debug
    type:
      - 'null'
      - int
    doc: Print command lines (1 to print, default 0)
    inputBinding:
      position: 101
      prefix: -d
  - id: ksize
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: -k
  - id: maximum_occurence
    type:
      - 'null'
      - int
    doc: Maximum occurence of an anchor, better correction for repetitive genome
      but slower
    inputBinding:
      position: 101
      prefix: -n
  - id: min_cov
    type:
      - 'null'
      - int
    doc: k-mers present strictly less than this number of times in the dataset 
      will be discarded
    inputBinding:
      position: 101
      prefix: -s
  - id: missmatch_allowed
    type:
      - 'null'
      - int
    doc: Maximum number of corrected bases
    inputBinding:
      position: 101
      prefix: -m
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: Number of cores used
    inputBinding:
      position: 101
      prefix: -t
  - id: out_dir
    type: string
    default: bcool_out
    doc: Path to store the results
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
    inputBinding:
      position: 101
      prefix: -i
  - id: unitig_coverage
    type:
      - 'null'
      - int
    doc: Unitig Coverage for cleaning
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: corrected_reads
    type: File
    doc: Corrected reads in FASTA format
    outputBinding:
      glob: $(inputs.out_dir)/reads_corrected.fa
  - id: graph
    type:
      - 'null'
      - File
    doc: De Bruijn graph unitigs used for correction
    outputBinding:
      glob: $(inputs.out_dir)/dbg*.fa
  - id: parameters_log
    type:
      - 'null'
      - File
    doc: Parameters used
    outputBinding:
      glob: $(inputs.out_dir)/ParametersUsed.txt
  - id: logs
    type:
      - 'null'
      - Directory
    doc: Log files of the BCALM and BGREAT steps
    outputBinding:
      glob: $(inputs.out_dir)/logs
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcool:1.0.0--py35_0
stdout: bcool.out
