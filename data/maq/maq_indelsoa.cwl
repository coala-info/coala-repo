cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - indelsoa
label: maq_indelsoa
doc: "Detect indel candidates from alignments.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: ref_bfa
    type: File
    doc: Reference genome in BFA format
    inputBinding:
      position: 1
  - id: align_map
    type: File
    doc: Alignment file in MAP format
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_indelsoa.out
