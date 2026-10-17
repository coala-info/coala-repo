cwlVersion: v1.2
class: CommandLineTool
baseCommand: pvrg-jpeg
label: pvrg-jpeg
doc: "PVRG JPEG codec for encoding and decoding images\n\nTool homepage: https://github.com/deepin-community/pvrg-jpeg"
inputs:
  - id: image_width
    type: int
    doc: Image width (width of the widest component)
    inputBinding:
      position: 1
      prefix: -iw
  - id: image_height
    type: int
    doc: Image height (height of the tallest component)
    inputBinding:
      position: 2
      prefix: -ih
  - id: jfif
    type:
      - 'null'
      - boolean
    doc: puts a JFIF marker. Don't change component indices.
    inputBinding:
      position: 3
      prefix: -JFIF
  - id: q_factor
    type:
      - 'null'
      - int
    doc: specifies quantization factor (8 bit quantization matrix)
    inputBinding:
      position: 3
      prefix: -q
  - id: q_factor_long
    type:
      - 'null'
      - int
    doc: specifies quantization factor (16 bit quantization matrix)
    inputBinding:
      position: 3
      prefix: -ql
  - id: reference_dct
    type:
      - 'null'
      - boolean
    doc: enables Reference DCT
    inputBinding:
      position: 3
      prefix: -a
  - id: lee_dct
    type:
      - 'null'
      - boolean
    doc: enables Lee DCT
    inputBinding:
      position: 3
      prefix: -b
  - id: decoder_enable
    type:
      - 'null'
      - boolean
    doc: decoder enable
    inputBinding:
      position: 3
      prefix: -d
  - id: lossless_mode
    type:
      - 'null'
      - int
    doc: enables lossless mode with the specified predictor type (1-7)
    inputBinding:
      position: 3
      prefix: -k
  - id: non_interleaved
    type:
      - 'null'
      - boolean
    doc: enables non-interleaved mode
    inputBinding:
      position: 3
      prefix: -n
  - id: command_interpreter
    type:
      - 'null'
      - boolean
    doc: enables the Command Interpreter (reads from standard input)
    inputBinding:
      position: 3
      prefix: -O
  - id: robust_mode
    type:
      - 'null'
      - boolean
    doc: run in robust mode against errors (cannot be used with DNL)
    inputBinding:
      position: 3
      prefix: -y
  - id: default_huffman
    type:
      - 'null'
      - boolean
    doc: uses default Huffman tables
    inputBinding:
      position: 3
      prefix: -z
  - id: pgm_headers
    type:
      - 'null'
      - boolean
    doc: put PGM headers on decode output files
    inputBinding:
      position: 3
      prefix: -g
  - id: precision
    type:
      - 'null'
      - int
    doc: specifies precision
    inputBinding:
      position: 3
      prefix: -p
  - id: point_transform
    type:
      - 'null'
      - int
    doc: the number of bits for the PT shift
    inputBinding:
      position: 3
      prefix: -t
  - id: resync_interval
    type:
      - 'null'
      - int
    doc: Resync interval
    inputBinding:
      position: 3
      prefix: -r
  - id: stream_name
    type:
      - 'null'
      - string
    doc: Name of the coded stream written when encoding (default ComponentFile1.jpg)
    inputBinding:
      position: 5
      prefix: -s
  - id: coded_stream
    type:
      - 'null'
      - File
    doc: Coded JPEG stream to read when decoding (-s)
    inputBinding:
      position: 5
      prefix: -s
  - id: out_base_name
    type:
      - 'null'
      - string
    doc: set a base name for decode output files
    inputBinding:
      position: 6
      prefix: -o
  - id: components
    type:
      - 'null'
      - type: array
        items: component_rec
    doc: Component files with their per-component options, in order
    inputBinding:
      position: 4
outputs:
  - id: encoded_stream
    type:
      - 'null'
      - File
    doc: Coded JPEG stream written when encoding
    outputBinding:
      glob: $(inputs.stream_name)
  - id: decoded_components
    type:
      - 'null'
      - type: array
        items: File
    doc: Raster component files written when decoding
    outputBinding:
      glob: |
        ${
          if (inputs.out_base_name) { return inputs.out_base_name + ".*"; }
          if (inputs.coded_stream) { return inputs.coded_stream.basename + ".*"; }
          return [];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: component_rec
        type: record
        fields:
          - name: component_index
            type: ['null', int]
            doc: Component index
            inputBinding:
              position: 1
              prefix: -ci
          - name: frame_width
            type: ['null', int]
            doc: Frame width for component
            inputBinding:
              position: 2
              prefix: -fw
          - name: frame_height
            type: ['null', int]
            doc: Frame height for component
            inputBinding:
              position: 3
              prefix: -fh
          - name: horizontal_frequency
            type: ['null', int]
            doc: Horizontal frequency for component
            inputBinding:
              position: 4
              prefix: -hf
          - name: vertical_frequency
            type: ['null', int]
            doc: Vertical frequency for component
            inputBinding:
              position: 5
              prefix: -vf
          - name: component_file
            type: File
            doc: Component file (raw raster, no PGM header)
            inputBinding:
              position: 6
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pvrg-jpeg:v1.2.1dfsg1-6-deb_cv1
