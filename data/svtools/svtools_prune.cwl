cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - prune
label: svtools_prune
doc: 'Cluster and prune a BEDPE file of breakpoint calls, keeping the best call per
  cluster.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_bedpe
    type: File
    doc: BEDPE file to read. If - or absent then defaults to stdin.
    inputBinding:
      position: 102
  - id: distance
    type:
      - 'null'
      - int
    doc: Max separation distance (bp) of adjacent loci in cluster [50]
    inputBinding:
      position: 101
      prefix: --distance
  - id: eval_param
    type:
      - 'null'
      - string
    doc: Evaluating parameter for choosing best bedpe in a cluster (e.g. af=AlleleFrequency
      default:af)
    inputBinding:
      position: 101
      prefix: --eval-param
  - id: is_sorted
    type:
      - 'null'
      - boolean
    doc: Specify if an input file is sorted. Sort with svtools bedpesort. (default=False)
    inputBinding:
      position: 101
      prefix: --is-sorted
  - id: output_bedpe
    type:
      - 'null'
      - string
    doc: 'Output bedpe to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: out_bedpe
    type:
      - 'null'
      - File
    doc: Pruned BEDPE
    outputBinding:
      glob: $(inputs.output_bedpe)
  - id: stdout
    type: stdout
    doc: Pruned BEDPE when --output is not given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_prune.out
