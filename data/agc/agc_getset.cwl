cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - getset
label: agc_getset
doc: "Assembled Genomes Compressor - extract a set of samples from an AGC file\n\n
  Tool homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
  - id: sample_names
    type:
      type: array
      items: string
    doc: Sample name(s) to extract
    inputBinding:
      position: 2
  - id: disable_prefetching
    type:
      - 'null'
      - boolean
    doc: disable file prefetching (useful for small genomes)
    inputBinding:
      position: 103
      prefix: -p
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: 'optional gzip with given level (default: 0; min: 0; max: 9)'
    default: 0
    inputBinding:
      position: 103
      prefix: -g
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'line length (default: 80; min: 40; max: 2000000000)'
    default: 80
    inputBinding:
      position: 103
      prefix: -l
  - id: streaming_mode
    type:
      - 'null'
      - boolean
    doc: enable streaming mode (slower but need less memory)
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: 'no of threads (default: 28; min: 1; max: 56)'
    default: 28
    inputBinding:
      position: 103
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level (default: 0; min: 0; max: 2)'
    default: 0
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output to file (default: output is sent to stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
