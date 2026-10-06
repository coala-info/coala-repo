cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, fakeksp]
requirements:
  - class: InlineJavascriptRequirement
label: bart_fakeksp
doc: "Recreate k-space from image and sensitivities.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: image
    type: File
    doc: Input image file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: kspace
    type: File
    doc: Input k-space file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: sens
    type: File
    doc: Input sensitivity map file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
  - id: replace_measured
    type:
      - 'null'
      - boolean
    doc: replace measured samples with original values
    inputBinding:
      position: 1
      prefix: -r
outputs:
  - id: output
    type: File
    doc: Output k-space file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
