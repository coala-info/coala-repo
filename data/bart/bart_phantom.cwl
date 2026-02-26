cwlVersion: v1.2
class: CommandLineTool
baseCommand: phantom
label: bart_phantom
doc: "Image and k-space domain phantoms.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 1
  - id: dimensions
    type:
      - 'null'
      - string
    doc: dimensions in y and z
    inputBinding:
      position: 102
      prefix: -x
  - id: geometric_object
    type:
      - 'null'
      - string
    doc: Geometric object phantom
    inputBinding:
      position: 102
      prefix: -G
  - id: is_3d
    type:
      - 'null'
      - boolean
    doc: 3D
    inputBinding:
      position: 102
      prefix: '-3'
  - id: k_space
    type:
      - 'null'
      - boolean
    doc: k-space
    inputBinding:
      position: 102
      prefix: -k
  - id: output_sensitivities
    type:
      - 'null'
      - string
    doc: Output nc sensitivities
    inputBinding:
      position: 102
      prefix: -S
  - id: sensitivities
    type:
      - 'null'
      - string
    doc: nc sensitivities
    inputBinding:
      position: 102
      prefix: -s
  - id: trajectory
    type:
      - 'null'
      - string
    doc: trajectory
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_phantom.out
