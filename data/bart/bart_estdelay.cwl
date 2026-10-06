cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, estdelay]
requirements:
  - class: InlineJavascriptRequirement
label: bart_estdelay
doc: "Estimate gradient delays from radial data.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: trajectory
    type: File
    doc: Trajectory file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: data
    type: File
    doc: Data file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: central_region_size
    type:
      - 'null'
      - float
    doc: '[RING] Central region size'
    inputBinding:
      position: 1
      prefix: -r
  - id: num_intersecting_spokes
    type:
      - 'null'
      - int
    doc: '[RING] Number of intersecting spokes'
    inputBinding:
      position: 1
      prefix: -n
  - id: padding
    type:
      - 'null'
      - int
    doc: '[RING] Padding'
    inputBinding:
      position: 1
      prefix: -p
  - id: ring_method
    type:
      - 'null'
      - boolean
    doc: RING method
    inputBinding:
      position: 1
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estdelay.out
