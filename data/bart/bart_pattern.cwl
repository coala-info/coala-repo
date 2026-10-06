cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, pattern]
requirements:
  - class: InlineJavascriptRequirement
label: bart_pattern
doc: "Compute sampling pattern from kspace\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: pattern
    type: string
    doc: pattern
    inputBinding:
      position: 11
  - id: squash_dimensions
    type:
      - 'null'
      - string
    doc: Squash dimensions selected by bitmask
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: pattern_file
    type: File
    doc: Array written as pattern.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.pattern).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
