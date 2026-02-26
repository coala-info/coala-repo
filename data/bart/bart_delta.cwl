cwlVersion: v1.2
class: CommandLineTool
baseCommand: delta
label: bart_delta
doc: "Calculates the delta between two images.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dims
    type: string
    doc: Dimensions of the images (e.g., '1024x768').
    inputBinding:
      position: 1
  - id: flags
    type: string
    doc: Flags to control delta calculation (e.g., '1' for difference, '2' for 
      MSE).
    inputBinding:
      position: 2
  - id: size
    type: int
    doc: Size parameter for delta calculation.
    inputBinding:
      position: 3
outputs:
  - id: out
    type: File
    doc: Output file for the delta image.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
