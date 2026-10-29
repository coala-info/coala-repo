cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_star_datablock_stack
label: relion_relion_star_datablock_stack
doc: "Print a STAR datablock with one row for each of N images in a stack.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: number_of_images
    type: int
    doc: Number of images in the stack
    inputBinding:
      position: 1
  - id: stack_name
    type: string
    doc: Name of the image stack
    inputBinding:
      position: 2
  - id: values
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional data values written after each image name (value1 value2 ...)
    inputBinding:
      position: 3
outputs:
  - id: datablock
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_star_datablock_stack.out
