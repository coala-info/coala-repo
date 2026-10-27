cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcf2pnm
label: xcftools_xcf2pnm
doc: "Convert GIMP XCF files to PNM (PPM/PGM/PBM) format\n\nTool homepage: https://github.com/j-jorge/xcftools"
inputs:
  - id: xcf_file
    type: File
    doc: The input XCF file (optionally compressed, see gzip/bzip/unpack).
    inputBinding:
      position: 2
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: Layer names to select; default is the whole image.
    inputBinding:
      position: 4
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages.
    inputBinding:
      position: 1
      prefix: -v
  - id: bzip
    type:
      - 'null'
      - boolean
    doc: Input is bzip2 compressed.
    inputBinding:
      position: 1
      prefix: -j
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Input is gzip compressed.
    inputBinding:
      position: 1
      prefix: -z
  - id: unpack
    type:
      - 'null'
      - string
    doc: Use 'command' to decompress input.
    inputBinding:
      position: 1
      prefix: -Z
  - id: utf8
    type:
      - 'null'
      - boolean
    doc: Use UTF-8 for layer names.
    inputBinding:
      position: 1
      prefix: -u
  - id: background
    type:
      - 'null'
      - string
    doc: Select background color.
    inputBinding:
      position: 1
      prefix: -b
  - id: force_alpha
    type:
      - 'null'
      - boolean
    doc: Force alpha channel in output.
    inputBinding:
      position: 1
      prefix: -A
  - id: color
    type:
      - 'null'
      - boolean
    doc: Select color output.
    inputBinding:
      position: 1
      prefix: -c
  - id: gray
    type:
      - 'null'
      - boolean
    doc: Select grayscale output.
    inputBinding:
      position: 1
      prefix: -g
  - id: mono
    type:
      - 'null'
      - boolean
    doc: Select monochrome output.
    inputBinding:
      position: 1
      prefix: -m
  - id: pnm
    type:
      - 'null'
      - boolean
    doc: Select color, grayscale or monochrome output by image contents.
    inputBinding:
      position: 1
      prefix: -n
  - id: alpha_map_path
    type:
      - 'null'
      - string
    doc: Write the transparency map to this file.
    inputBinding:
      position: 1
      prefix: -a
  - id: truecolor
    type:
      - 'null'
      - boolean
    doc: Treat indexed images as RGB for flattening.
    inputBinding:
      position: 1
      prefix: -T
  - id: for_gif
    type:
      - 'null'
      - boolean
    doc: Disallow partial transparency.
    inputBinding:
      position: 1
      prefix: -G
  - id: dissolve
    type:
      - 'null'
      - boolean
    doc: Dissolve partial transparency.
    inputBinding:
      position: 1
      prefix: -D
  - id: full_image
    type:
      - 'null'
      - boolean
    doc: Flatten to memory; then analyse.
    inputBinding:
      position: 1
      prefix: -f
  - id: size
    type:
      - 'null'
      - string
    doc: Crop image while converting (WxH).
    inputBinding:
      position: 1
      prefix: -S
  - id: offset
    type:
      - 'null'
      - string
    doc: Translate converted part of image (x,y).
    inputBinding:
      position: 1
      prefix: -O
  - id: autocrop
    type:
      - 'null'
      - boolean
    doc: Autocrop to visible layer boundaries.
    inputBinding:
      position: 1
      prefix: -C
  - id: layer_mode
    type:
      - 'null'
      - string
    doc: Set layer mode (applies to the last layer named; the option must follow a layer name).
    inputBinding:
      position: 5
      prefix: --mode
  - id: percent
    type:
      - 'null'
      - int
    doc: Set opacity in percent.
    inputBinding:
      position: 5
      prefix: --percent
  - id: opacity
    type:
      - 'null'
      - int
    doc: Set opacity in 1/255 units.
    inputBinding:
      position: 5
      prefix: --opacity
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Enable layer mask.
    inputBinding:
      position: 5
      prefix: --mask
  - id: nomask
    type:
      - 'null'
      - boolean
    doc: Disable layer mask.
    inputBinding:
      position: 5
      prefix: --nomask
  - id: output_path
    type: string
    doc: Name of the output file.
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output
    type: File
    doc: The converted image.
    outputBinding:
      glob: $(inputs.output_path)
  - id: alpha_map
    type:
      - 'null'
      - File
    doc: The transparency map, when requested with alpha_map_path.
    outputBinding:
      glob: $(inputs.alpha_map_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xcftools:1.0.7--0
