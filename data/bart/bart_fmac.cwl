cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, fmac]
requirements:
  - class: InlineJavascriptRequirement
label: bart_fmac
doc: "Multiply <input1> and <input2> and accumulate in <output>. If <input2> is not
  specified, assume all-ones.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input1
    type: File
    doc: First input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: input2
    type:
      - 'null'
      - File
    doc: Second input file (optional, defaults to all-ones)
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: add_to_existing
    type:
      - 'null'
      - boolean
    doc: add to existing output (instead of overwriting)
    inputBinding:
      position: 1
      prefix: -A
  - id: conjugate_input2
    type:
      - 'null'
      - boolean
    doc: conjugate input2
    inputBinding:
      position: 1
      prefix: -C
  - id: squash_dimensions
    type:
      - 'null'
      - string
    doc: squash dimensions selected by bitmask b
    inputBinding:
      position: 1
      prefix: -s
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
