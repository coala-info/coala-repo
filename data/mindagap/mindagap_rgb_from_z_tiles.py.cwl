cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgb_from_z_tiles.py
label: mindagap_rgb_from_z_tiles.py
doc: "Reads 3 3D tif files, extracts desired z layer and creates 3-channel RGB tiff
  image\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.output_dir ? {class: 'Directory', basename: inputs.output_dir, listing: []} : null)"
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
      - string
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
      - string
    doc: The desired Z layers to keep. Accepts layer numbers, slices or both,
      separated by commas (no spaces), for example 2,4-6,9.
    inputBinding:
      position: 101
      prefix: --z
outputs:
  - id: rgb_png
    type:
      - 'null'
      - type: array
        items: File
    doc: RGB png images written by the tool
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir + '/*_RGB.png' : '*_RGB.png')"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_rgb_from_z_tiles.py.out
