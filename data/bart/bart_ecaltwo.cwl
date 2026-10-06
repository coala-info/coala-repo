cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, ecaltwo]
requirements:
  - class: InlineJavascriptRequirement
label: bart_ecaltwo
doc: "Second part of ESPIRiT calibration. Optionally outputs the eigenvalue maps.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: x
    type: int
    doc: x
    inputBinding:
      position: 10
  - id: y
    type: int
    doc: y
    inputBinding:
      position: 11
  - id: z
    type: int
    doc: z
    inputBinding:
      position: 12
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 13
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: sensitivities
    type: string
    doc: Sensitivities
    inputBinding:
      position: 14
  - id: ev_maps
    type:
      - 'null'
      - string
    doc: Optional eigenvalue maps output
    inputBinding:
      position: 15
  - id: crop_value
    type:
      - 'null'
      - float
    doc: Crop the sensitivities if the eigenvalue is smaller than {crop_value}.
    inputBinding:
      position: 1
      prefix: -c
  - id: maps
    type:
      - 'null'
      - int
    doc: Number of maps to compute.
    inputBinding:
      position: 1
      prefix: -m
  - id: soft_sense
    type:
      - 'null'
      - boolean
    doc: Create maps with smooth transitions (Soft-SENSE).
    inputBinding:
      position: 1
      prefix: -S
outputs:
  - id: sensitivities_out
    type: File
    doc: Array written as sensitivities.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.sensitivities).cfl
  - id: ev_maps_out
    type:
      - 'null'
      - File
    doc: Array written as ev_maps.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.ev_maps).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
