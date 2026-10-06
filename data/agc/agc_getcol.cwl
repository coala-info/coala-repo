cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - getcol
label: agc_getcol
doc: "Assembled Genomes Compressor - get collection of sequences\n\nTool homepage:
  https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: fast mode (needs more RAM)
    inputBinding:
      position: 102
      prefix: -f
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: 'optional gzip with given level (min: 0; max: 9)'
    inputBinding:
      position: 102
      prefix: -g
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'line length (min: 40; max: 2000000000)'
    inputBinding:
      position: 102
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: 'no of threads (min: 1; max: 56)'
    inputBinding:
      position: 102
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level (min: 0; max: 2)'
    inputBinding:
      position: 102
      prefix: -v
  - id: without_reference
    type:
      - 'null'
      - boolean
    doc: without reference
    inputBinding:
      position: 102
      prefix: -r
  - id: output_path_path
    type: string
    doc: Output directory; one FASTA file per sample is written in it. The 
      directory is created before the run because agc needs it to exist.
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_path
    type: Directory
    doc: Directory with one FASTA file per sample.
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.output_path_path, "listing":
          []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
