cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgb_from_z_tiles.py
label: mindagap_rgb_from_z_tiles.py
doc: "Reads 3 3D tif files, extracts desired z layer and creates 3-channel RGB tiff
  image\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs:
  - id: blue
    type: File
    doc: DAPI tif
    inputBinding:
      position: 101
      prefix: --blue
  - id: blue_padding
    type:
      - 'null'
      - int
    doc: Average X blue layers around asked Z layer
    inputBinding:
      position: 101
      prefix: --blue_padding
  - id: correct_ilum
    type:
      - 'null'
      - float
    doc: Correct ilumination for Red channel. 1.0 to 3.0 for fine tunning. 0 to 
      turn off.
    inputBinding:
      position: 101
      prefix: --correct_ilum
  - id: green
    type:
      - 'null'
      - File
    doc: Constructive signal tif
    inputBinding:
      position: 101
      prefix: --green
  - id: green_padding
    type:
      - 'null'
      - int
    doc: Add X green layers around asked Z layer
    inputBinding:
      position: 101
      prefix: --green_padding
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory to save RGB tif files
    inputBinding:
      position: 101
      prefix: --out
  - id: red
    type:
      - 'null'
      - File
    doc: WGA (cellwall stain) tif
    inputBinding:
      position: 101
      prefix: --red
  - id: z
    type:
      - 'null'
      - int
    doc: The desired Z layers to keep
    inputBinding:
      position: 101
      prefix: --z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_rgb_from_z_tiles.py.out
