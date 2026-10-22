cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - ilv
label: seqfu_interleave
doc: "Interleave FASTQ pair ends. By default the forward file is scanned for _R1. and\n_R2. is substituted\
  \ to find the second file (then _1. and _2.).\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: forward_pair
    type: File
    doc: forward-pair FASTQ file
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reverse_pair
    type:
      - 'null'
      - File
    doc: reverse-pair FASTQ file (guessed from the forward one when not set)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: for_tag
    type:
      - 'null'
      - string
    doc: 'string identifying forward files [default: auto]'
    inputBinding:
      position: 102
      prefix: --for-tag
  - id: rev_tag
    type:
      - 'null'
      - string
    doc: 'string identifying reverse files [default: auto]'
    inputBinding:
      position: 102
      prefix: --rev-tag
  - id: output_path
    type:
      - 'null'
      - string
    doc: save file to <out-file> instead of STDOUT
    inputBinding:
      position: 102
      prefix: --output
  - id: check
    type:
      - 'null'
      - boolean
    doc: enable careful mode (check sequence names and numbers)
    inputBinding:
      position: 102
      prefix: --check
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: skip comments
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: prefix
    type:
      - 'null'
      - string
    doc: rename sequences (append a progressive number)
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Interleaved FASTQ file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_interleave.out
