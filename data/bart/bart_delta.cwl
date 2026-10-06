cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, delta]
requirements:
  - class: InlineJavascriptRequirement
label: bart_delta
doc: "Calculates the delta between two images.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dims
    type: string
    doc: Dimensions of the images (e.g., '1024x768').
    inputBinding:
      position: 10
  - id: flags
    type: string
    doc: Flags to control delta calculation (e.g., '1' for difference, '2' for 
      MSE).
    inputBinding:
      position: 11
  - id: size
    type: int
    doc: Size parameter for delta calculation.
    inputBinding:
      position: 12
  - id: out_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
outputs:
  - id: out
    type: File
    doc: Output file for the delta image.
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.out_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
