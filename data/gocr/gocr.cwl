cwlVersion: v1.2
class: CommandLineTool
baseCommand: gocr
label: gocr
doc: "Optical Character Recognition\n\nTool homepage: https://jocr.sourceforge.net"
inputs:
  - id: input_file
    type: File
    doc: input image file (pnm,pgm,pbm,ppm,pcx,...)
    inputBinding:
      position: 1
  - id: certainty_value
    type:
      - 'null'
      - int
    doc: value of certainty (in percent, 0..100, default=95)
    inputBinding:
      position: 102
      prefix: -a
  - id: char_filter
    type:
      - 'null'
      - string
    doc: 'char filter (ex. hexdigits: 0-9A-Fx, only ASCII)'
    inputBinding:
      position: 102
      prefix: -C
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: database path including final slash
    inputBinding:
      position: 102
      prefix: -p
  - id: debug_chars
    type:
      - 'null'
      - string
    doc: list of chars (debugging, see manual)
    inputBinding:
      position: 102
      prefix: -c
  - id: dust_size
    type:
      - 'null'
      - int
    doc: dust_size (remove small clusters, -1 = autodetect)
    inputBinding:
      position: 102
      prefix: -d
  - id: operation_modes
    type:
      - 'null'
      - int
    doc: operation modes (bitpattern, see manual)
    inputBinding:
      position: 102
      prefix: -m
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format (ISO8859_1 TeX HTML XML UTF8 ASCII)
    inputBinding:
      position: 102
      prefix: -f
  - id: progress_fifo
    type:
      - 'null'
      - File
    doc: progress output to fifo (see manual)
    inputBinding:
      position: 102
      prefix: -x
  - id: spacewidth_dots
    type:
      - 'null'
      - int
    doc: spacewidth/dots (0 = autodetect)
    inputBinding:
      position: 102
      prefix: -s
  - id: threshold_grey_level
    type:
      - 'null'
      - int
    doc: threshold grey level 0<160<=255 (0 = autodetect)
    inputBinding:
      position: 102
      prefix: -l
  - id: unrecognized_char_string
    type:
      - 'null'
      - string
    doc: output this string for every unrecognized character
    inputBinding:
      position: 102
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbose (see manual page)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file  (redirection of stdout)
    outputBinding:
      glob: $(inputs.output_file)
  - id: logging_file
    type:
      - 'null'
      - File
    doc: logging file (redirection of stderr)
    outputBinding:
      glob: $(inputs.logging_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gocr:0.52--h7b50bb2_0
