cwlVersion: v1.2
class: CommandLineTool
baseCommand: jellyfish_jf
label: jellyfish_jf
doc: "Count k-mers in DNA, RNA or protein sequences.\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ files
    inputBinding:
      position: 1
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: count canonical k-mers only
    inputBinding:
      position: 102
      prefix: --canonical
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: count k-mers only, do not store them
    inputBinding:
      position: 102
      prefix: --count-only
  - id: k
    type: int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: --k
  - id: max_freq
    type:
      - 'null'
      - int
    doc: maximum frequency
    inputBinding:
      position: 102
      prefix: --max-freq
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: memory limit in MiB
    inputBinding:
      position: 102
      prefix: --memory-limit
  - id: min_freq
    type:
      - 'null'
      - int
    doc: minimum frequency
    default: 1
    inputBinding:
      position: 102
      prefix: --min-freq
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format (ascii or binary)
    default: ascii
    inputBinding:
      position: 102
      prefix: --output-format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress progress messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
