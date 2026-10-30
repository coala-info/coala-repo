cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripplesInit
label: usher_ripplesInit
doc: 'ripplesInit: lists the candidate recombinant nodes (initial filtering step of
  ripples) of a mutation-annotated tree (MAT).


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED].
  inputBinding:
    position: 101
    prefix: --input-mat
- id: branch_length
  type:
  - 'null'
  - int
  doc: 'Minimum length of the branch to consider to recombination events [default:
    3]'
  inputBinding:
    position: 101
    prefix: --branch-length
- id: num_descendants
  type:
  - 'null'
  - int
  doc: 'Minimum number of leaves that node should have to be considered for recombination.
    [default: 2]'
  inputBinding:
    position: 101
    prefix: --num-descendants
outputs:
- id: stdout_log
  type: stdout
  doc: Standard output (candidate node list and messages).
stdout: ripplesInit_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
