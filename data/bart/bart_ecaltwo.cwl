cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecaltwo
label: bart_ecaltwo
doc: "Second part of ESPIRiT calibration. Optionally outputs the eigenvalue maps.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: sensitivities
    type: string
    doc: Sensitivities
    inputBinding:
      position: 2
  - id: ev_maps
    type:
      - 'null'
      - File
    doc: Optional eigenvalue maps output
    inputBinding:
      position: 3
  - id: crop_value
    type:
      - 'null'
      - float
    doc: Crop the sensitivities if the eigenvalue is smaller than {crop_value}.
    inputBinding:
      position: 104
      prefix: -c
  - id: maps
    type:
      - 'null'
      - int
    doc: Number of maps to compute.
    inputBinding:
      position: 104
      prefix: -m
  - id: soft_sense
    type:
      - 'null'
      - boolean
    doc: Create maps with smooth transitions (Soft-SENSE).
    inputBinding:
      position: 104
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_ecaltwo.out
