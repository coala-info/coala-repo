cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, walsh]
requirements:
  - class: InlineJavascriptRequirement
label: bart_walsh
doc: "Estimate coil sensitivities using walsh method (use with ecaltwo).\n\nTool homepage:
  https://github.com/mrirecon/bart"
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
  - id: block_size
    type:
      - 'null'
      - string
    doc: Block size.
    inputBinding:
      position: 1
      prefix: -b
  - id: calibration_region_size
    type:
      - 'null'
      - string
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 1
      prefix: -r
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
