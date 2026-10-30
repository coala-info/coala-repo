cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- fix
label: usher_matUtils_fix
doc: 'matUtils fix: fixes grandparent-reversion structures in a mutation-annotated
  tree (MAT).


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --input-mat
- id: output_mat
  type: string
  doc: Path to output fixed mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --output-mat
- id: iterations
  type:
  - 'null'
  - int
  doc: 'Number of iterations to run [default: 1]'
  inputBinding:
    position: 101
    prefix: --iterations
- id: min_descendent_count
  type:
  - 'null'
  - int
  doc: 'Minimum number of descendents required to move a node [default: 1]'
  inputBinding:
    position: 101
    prefix: --min-descendent-count
outputs:
- id: output_mat_file
  type: File
  doc: Output file named by --output-mat. Path to output fixed mutation-annotated
    tree file [REQUIRED]
  outputBinding:
    glob: $(inputs.output_mat)
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matUtils_fix_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
