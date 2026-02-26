cwlVersion: v1.2
class: CommandLineTool
baseCommand: estdelay
label: bart_estdelay
doc: "Estimate gradient delays from radial data.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: trajectory
    type: string
    doc: Trajectory file
    inputBinding:
      position: 1
  - id: data
    type: string
    doc: Data file
    inputBinding:
      position: 2
  - id: central_region_size
    type:
      - 'null'
      - float
    doc: '[RING] Central region size'
    inputBinding:
      position: 103
      prefix: -r
  - id: num_intersecting_spokes
    type:
      - 'null'
      - float
    doc: '[RING] Number of intersecting spokes'
    inputBinding:
      position: 103
      prefix: -n
  - id: padding
    type:
      - 'null'
      - float
    doc: '[RING] Padding'
    inputBinding:
      position: 103
      prefix: -p
  - id: ring_method
    type:
      - 'null'
      - boolean
    doc: RING method
    inputBinding:
      position: 103
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estdelay.out
