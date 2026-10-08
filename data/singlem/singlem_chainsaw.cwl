cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - singlem
  - chainsaw
label: singlem_chainsaw
doc: 'Remove tree information and trim unaligned sequences from a SingleM package
  (expert mode)


  Tool homepage: https://github.com/wwood/singlem'
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_singlem_package
    type: Directory
    doc: Remove tree info and trim unaligned sequences from this package
    inputBinding:
      position: 101
      prefix: --input-singlem-package
  - id: keep_tree
    type:
      - 'null'
      - boolean
    doc: Stop tree info from being removed
    inputBinding:
      position: 101
      prefix: --keep-tree
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sequence_prefix
    type:
      - 'null'
      - string
    doc: Rename the sequences by adding this at the front
    inputBinding:
      position: 101
      prefix: --sequence-prefix
  - id: output_singlem_package_path
    type: string
    inputBinding:
      position: 102
      prefix: --output-singlem-package
outputs:
  - id: output_singlem_package
    type: Directory
    doc: Package to be created
    outputBinding:
      glob: $(inputs.output_singlem_package_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
