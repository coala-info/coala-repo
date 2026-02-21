cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindagap_rgb_from_z_tiles.py
label: mindagap_rgb_from_z_tiles.py
doc: "A tool to create RGB images from Z-stack tiles. (Note: The provided help text
  contains only container environment logs and error messages, and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_rgb_from_z_tiles.py.out
