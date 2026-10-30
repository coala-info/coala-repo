cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- merge
label: usher_matUtils_merge
doc: 'matUtils merge: merges all samples of two input mutation-annotated tree (MAT)
  files into a single output MAT.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat_1
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]. If only this argument is set,
    print the count of samples and nodes in the tree.
  inputBinding:
    position: 101
    prefix: --input-mat-1
- id: input_mat_2
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]. If only this argument is set,
    print the count of samples and nodes in the tree.
  inputBinding:
    position: 101
    prefix: --input-mat-2
- id: output_mat
  type: string
  doc: Write output files to the target directory. Default is current directory.
  inputBinding:
    position: 101
    prefix: --output-mat
- id: max_depth
  type:
  - 'null'
  - int
  doc: 'Max depth to consider in the subtree rooted at the consistent node. [default:
    20]'
  inputBinding:
    position: 101
    prefix: --max-depth
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
outputs:
- id: output_mat_file
  type: File
  doc: Output file named by --output-mat. Write output files to the target directory.
    Default is current directory.
  outputBinding:
    glob: $(inputs.output_mat)
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matUtils_merge_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
