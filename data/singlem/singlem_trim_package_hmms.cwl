cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem_trim_package_hmms
label: singlem_trim_package_hmms
doc: "Trim the width of HMMs to increase speed (expert mode)\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: input_singlem_package
    type: File
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
outputs:
  - id: output_singlem_package
    type: File
    doc: Package to be created
    outputBinding:
      glob: $(inputs.output_singlem_package)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
