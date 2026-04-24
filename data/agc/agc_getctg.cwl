cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - getctg
label: agc_getctg
doc: "Extract contigs from an AGC (Assembled Genomes Compressor) file. Supports various
  formats for specifying contigs, samples, and ranges.\n\nTool homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
  - id: contigs
    type:
      type: array
      items: string
    doc: Contig identifiers (can include @sample and :from-to range)
    inputBinding:
      position: 2
  - id: disable_prefetching
    type:
      - 'null'
      - boolean
    doc: disable file prefetching (useful for short queries)
    inputBinding:
      position: 103
      prefix: -p
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: 'optional gzip with given level (min: 0; max: 9)'
    inputBinding:
      position: 103
      prefix: -g
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'line length (min: 40; max: 2000000000)'
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
    doc: 'no of threads (min: 1; max: 56)'
    inputBinding:
      position: 103
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level (min: 0; max: 2)'
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
