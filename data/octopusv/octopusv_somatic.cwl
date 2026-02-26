cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - somatic
label: octopusv_somatic
doc: "Extract somatic SVs by finding tumor-specific variants (tumor - normal intersection).\n\
  \nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum allowed distance for merging events.
    default: 50
    inputBinding:
      position: 101
      prefix: --max-distance
  - id: max_length_ratio
    type:
      - 'null'
      - float
    doc: Maximum allowed ratio between event lengths.
    default: 1.3
    inputBinding:
      position: 101
      prefix: --max-length-ratio
  - id: min_jaccard
    type:
      - 'null'
      - float
    doc: Minimum required Jaccard index for overlap.
    default: 0.7
    inputBinding:
      position: 101
      prefix: --min-jaccard
  - id: normal
    type: File
    doc: Normal SVCF file.
    inputBinding:
      position: 101
      prefix: --normal
  - id: tumor
    type: File
    doc: Tumor SVCF file.
    inputBinding:
      position: 101
      prefix: --tumor
outputs:
  - id: output_file
    type: File
    doc: Output somatic SV file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
