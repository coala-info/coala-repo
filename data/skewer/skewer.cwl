cwlVersion: v1.2
class: CommandLineTool
baseCommand: skewer
label: skewer
doc: "A fast and sensitive adapter trimmer for next-generation sequencing (NGS) paired-end
  reads.\n\nTool homepage: https://github.com/skeeto/skewer-mode"
inputs:
  - id: input_file_1
    type: File
    doc: Input file (forward reads)
    inputBinding:
      position: 1
  - id: input_file_2
    type:
      - 'null'
      - File
    doc: Input file (reverse reads for paired-end mode)
    inputBinding:
      position: 2
  - id: adapter_seq
    type:
      - 'null'
      - string
    doc: Adapter sequence
    inputBinding:
      position: 103
      prefix: --adapter
  - id: adapter_seq_2
    type:
      - 'null'
      - string
    doc: Adapter sequence for the second read
    inputBinding:
      position: 103
      prefix: --adapter2
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output in GZIP format
    inputBinding:
      position: 103
      prefix: --compress
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length allowed after trimming
    inputBinding:
      position: 103
      prefix: --min
  - id: mode
    type:
      - 'null'
      - string
    doc: Trimming mode; one of 'single', 'paired', or 'ap' (any paired)
    inputBinding:
      position: 103
      prefix: --mode
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 103
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: The prefix of output filenames
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skewer:0.2.2--h2d50403_2
