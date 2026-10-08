cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - singlem
  - trim_package_hmms
label: singlem_trim_package_hmms
doc: 'Trim the width of HMMs to increase speed (expert mode)


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
    doc: Input package to trim HMMs from
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
