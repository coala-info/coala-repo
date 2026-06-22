cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - transfer_annotations
label: phykit_transfer_annotations
doc: 'Transfer internal node annotations from one tree onto another. Matches nodes
  by bipartition (descendant taxa set) and copies the annotation labels. Typical use
  case: transfer wASTRAL support annotations from an annotated ASTRAL tree onto a
  branch-length-optimized topology.'
inputs:
  - id: source
    type: File
    doc: annotated tree file (e.g., wASTRAL output with --support 3)
    inputBinding:
      position: 101
      prefix: --source
  - id: target
    type:
      - 'null'
      - File
    doc: target tree file with branch lengths to keep (e.g., RAxML-NG or IQ-TREE
      output)
    inputBinding:
      position: 101
      prefix: --target
  - id: output
    type: string
    doc: 'output file for the annotated tree (default: target file + ".annotated")'
    inputBinding:
      position: 101
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: 'output file for the annotated tree (default: target file + ".annotated")'
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
