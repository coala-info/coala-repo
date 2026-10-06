cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, phantom]
requirements:
  - class: InlineJavascriptRequirement
label: bart_phantom
doc: "Image and k-space domain phantoms.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 10
  - id: dimensions
    type:
      - 'null'
      - int
    doc: dimensions in y and z
    inputBinding:
      position: 1
      prefix: -x
  - id: geometric_object
    type:
      - 'null'
      - int
    doc: Geometric object phantom
    inputBinding:
      position: 1
      prefix: -G
  - id: is_3d
    type:
      - 'null'
      - boolean
    doc: 3D
    inputBinding:
      position: 1
      prefix: '-3'
  - id: k_space
    type:
      - 'null'
      - boolean
    doc: k-space
    inputBinding:
      position: 1
      prefix: -k
  - id: output_sensitivities
    type:
      - 'null'
      - int
    doc: Output nc sensitivities
    inputBinding:
      position: 1
      prefix: -S
  - id: sensitivities
    type:
      - 'null'
      - int
    doc: nc sensitivities
    inputBinding:
      position: 1
      prefix: -s
  - id: trajectory
    type:
      - 'null'
      - File
    doc: trajectory
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -t
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
