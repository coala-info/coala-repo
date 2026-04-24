cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing2
  - wsketch
label: dashing2_wsketch
doc: "Sketch raw IDs, with optional weights added\n\nTool homepage: https://github.com/dnbaker/dashing2"
inputs:
  - id: input_bin
    type: File
    doc: Input binary file containing raw IDs or indices
    inputBinding:
      position: 1
  - id: input_weights_bin
    type:
      - 'null'
      - File
    doc: Optional input binary file containing weights
    inputBinding:
      position: 2
  - id: indptr_bin
    type:
      - 'null'
      - File
    doc: Optional input binary file for CSR data (indptr)
    inputBinding:
      position: 3
  - id: bag_minhash
    type:
      - 'null'
      - boolean
    doc: Sketch with BagMinHash. This treats datasets as multisets.
    inputBinding:
      position: 104
      prefix: -B
  - id: outprefix
    type:
      - 'null'
      - string
    doc: outprefix. If unset, uses [input.bin]
    inputBinding:
      position: 104
      prefix: -o
  - id: read_16bit_data_weights
    type:
      - 'null'
      - boolean
    doc: Read 16-bit data weights from [input.weight.bin]
    inputBinding:
      position: 104
      prefix: -H
  - id: read_32bit_data_weights
    type:
      - 'null'
      - boolean
    doc: Read 32-bit data weights from [input.weight.bin]
    inputBinding:
      position: 104
      prefix: -U
  - id: read_32bit_float_weights
    type:
      - 'null'
      - boolean
    doc: Read 32-bit floating point weights from [input.weights.bin]
    inputBinding:
      position: 104
      prefix: -f
  - id: read_32bit_identifiers
    type:
      - 'null'
      - boolean
    doc: Read 32-bit identifiers from input.bin rather than 64-bit
    inputBinding:
      position: 104
      prefix: -u
  - id: read_32bit_indptr_integers
    type:
      - 'null'
      - boolean
    doc: Read 32-bit indptr integers [indptr.bin]
    inputBinding:
      position: 104
      prefix: -P
  - id: set_sketch
    type:
      - 'null'
      - boolean
    doc: Sketch with SetSketch
    inputBinding:
      position: 104
      prefix: -q
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Set sketch size
    inputBinding:
      position: 104
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads (processes)
    inputBinding:
      position: 104
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing2:2.1.20--he9e5f93_0
stdout: dashing2_wsketch.out
