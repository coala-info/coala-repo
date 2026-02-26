cwlVersion: v1.2
class: CommandLineTool
baseCommand: walsh
label: bart_walsh
doc: "Estimate coil sensitivities using walsh method (use with ecaltwo).\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: block_size
    type:
      - 'null'
      - type: array
        items: string
    doc: Block size.
    inputBinding:
      position: 102
      prefix: -b
  - id: calibration_region_size
    type:
      - 'null'
      - type: array
        items: string
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
