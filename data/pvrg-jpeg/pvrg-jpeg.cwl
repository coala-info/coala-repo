cwlVersion: v1.2
class: CommandLineTool
baseCommand: jpeg
label: pvrg-jpeg
doc: "PVRG JPEG codec for encoding and decoding images\n\nTool homepage: https://github.com/deepin-community/pvrg-jpeg"
inputs:
  - id: component_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Component file(s)
    inputBinding:
      position: 1
  - id: command_interpreter
    type:
      - 'null'
      - boolean
    doc: enables the Command Interpreter
    inputBinding:
      position: 102
      prefix: -O
  - id: component_index
    type:
      - 'null'
      - type: array
        items: int
    doc: Component index
    inputBinding:
      position: 102
      prefix: -ci
  - id: decoder_enable
    type:
      - 'null'
      - boolean
    doc: decoder enable
    inputBinding:
      position: 102
      prefix: -d
  - id: default_huffman
    type:
      - 'null'
      - boolean
    doc: uses default Huffman tables
    inputBinding:
      position: 102
      prefix: -z
  - id: frame_height
    type:
      - 'null'
      - type: array
        items: int
    doc: Frame height for component
    inputBinding:
      position: 102
      prefix: -fh
  - id: frame_width
    type:
      - 'null'
      - type: array
        items: int
    doc: Frame width for component
    inputBinding:
      position: 102
      prefix: -fw
  - id: horizontal_frequency
    type:
      - 'null'
      - type: array
        items: int
    doc: Horizontal frequency for component
    inputBinding:
      position: 102
      prefix: -hf
  - id: image_height
    type: int
    doc: Image height
    inputBinding:
      position: 102
      prefix: -ih
  - id: image_width
    type: int
    doc: Image width
    inputBinding:
      position: 102
      prefix: -iw
  - id: jfif
    type:
      - 'null'
      - boolean
    doc: puts a JFIF marker. Don't change component indices.
    inputBinding:
      position: 102
      prefix: -JFIF
  - id: lee_dct
    type:
      - 'null'
      - boolean
    doc: enables Lee DCT
    inputBinding:
      position: 102
      prefix: -b
  - id: lossless_mode
    type:
      - 'null'
      - string
    doc: enables lossless mode with specified predictor type
    inputBinding:
      position: 102
      prefix: -k
  - id: non_interleaved
    type:
      - 'null'
      - boolean
    doc: enables non-interleaved mode
    inputBinding:
      position: 102
      prefix: -n
  - id: pgm_headers
    type:
      - 'null'
      - boolean
    doc: put PGM headers on decode output files
    inputBinding:
      position: 102
      prefix: -g
  - id: point_transform
    type:
      - 'null'
      - int
    doc: the number of bits for the PT shift
    inputBinding:
      position: 102
      prefix: -t
  - id: precision
    type:
      - 'null'
      - int
    doc: specifies precision
    inputBinding:
      position: 102
      prefix: -p
  - id: q_factor
    type:
      - 'null'
      - int
    doc: specifies quantization factor
    inputBinding:
      position: 102
      prefix: -q
  - id: q_factor_long
    type:
      - 'null'
      - int
    doc: specifies quantization factor (long)
    inputBinding:
      position: 102
      prefix: -ql
  - id: reference_dct
    type:
      - 'null'
      - boolean
    doc: enables Reference DCT
    inputBinding:
      position: 102
      prefix: -a
  - id: resync_interval
    type:
      - 'null'
      - int
    doc: Resync interval
    inputBinding:
      position: 102
      prefix: -r
  - id: robust_mode
    type:
      - 'null'
      - boolean
    doc: run in robust mode against errors (cannot be used with DNL)
    inputBinding:
      position: 102
      prefix: -y
  - id: stream_name
    type:
      - 'null'
      - string
    doc: Stream name
    inputBinding:
      position: 102
      prefix: -s
  - id: vertical_frequency
    type:
      - 'null'
      - type: array
        items: int
    doc: Vertical frequency for component
    inputBinding:
      position: 102
      prefix: -vf
outputs:
  - id: out_base_name
    type:
      - 'null'
      - File
    doc: set a base name for decode output files
    outputBinding:
      glob: $(inputs.out_base_name)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pvrg-jpeg:v1.2.1dfsg1-6-deb_cv1
