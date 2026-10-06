cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, noise]
requirements:
  - class: InlineJavascriptRequirement
label: bart_noise
doc: "Add noise with selected variance to input.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 11
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random seed initialization
    inputBinding:
      position: 1
      prefix: -s
  - id: real_valued_input
    type:
      - 'null'
      - boolean
    doc: real-valued input
    inputBinding:
      position: 1
      prefix: -r
  - id: variance
    type:
      - 'null'
      - float
    doc: variance
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
