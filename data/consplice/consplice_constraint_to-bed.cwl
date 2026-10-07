cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - to-bed
label: consplice_constraint_to-bed
doc: "Convert the 1-based scored ConSplice txt file to a 0-based bed file.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: score_file
    type: File
    doc: 'The path to the scored ConSplice txt file to convert to a 0-based bed file.'
    inputBinding:
      position: 1
      prefix: --score-file
  - id: out_file
    type: string
    doc: 'The name of the output bed file to create (.bed or .bed.gz is added when missing).'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'The output file type: ''bed'' or ''bedgz''. Default = ''bed''.'
    inputBinding:
      position: 1
      prefix: --out-type
outputs:
  - id: output
    type: File
    doc: 'The 0-based ConSplice bed file.'
    outputBinding:
      glob: $(inputs.out_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
