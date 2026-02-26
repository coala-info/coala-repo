cwlVersion: v1.2
class: CommandLineTool
baseCommand: fakeksp
label: bart_fakeksp
doc: "Recreate k-space from image and sensitivities.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: image
    type: File
    doc: Input image file
    inputBinding:
      position: 1
  - id: kspace
    type: File
    doc: Input k-space file
    inputBinding:
      position: 2
  - id: sens
    type: File
    doc: Input sensitivity map file
    inputBinding:
      position: 3
  - id: replace_measured
    type:
      - 'null'
      - boolean
    doc: replace measured samples with original values
    inputBinding:
      position: 104
      prefix: -r
outputs:
  - id: output
    type: File
    doc: Output k-space file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
