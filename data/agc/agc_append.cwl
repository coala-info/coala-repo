cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - append
label: agc_append
doc: "Assembled Genomes Compressor - append genomes to an existing archive\n\nTool
  homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
  - id: input_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA files to append
    inputBinding:
      position: 2
  - id: adaptive_mode
    type:
      - 'null'
      - boolean
    doc: adaptive mode
    default: false
    inputBinding:
      position: 103
      prefix: -a
  - id: concatenated_genomes
    type:
      - 'null'
      - boolean
    doc: concatenated genomes in a single file
    default: false
    inputBinding:
      position: 103
      prefix: -c
  - id: do_not_store_cmd_line
    type:
      - 'null'
      - boolean
    doc: do not store cmd-line
    default: true
    inputBinding:
      position: 103
      prefix: -d
  - id: fallback_minimizers_fraction
    type:
      - 'null'
      - float
    doc: fraction of fall-back minimizers
    default: 0.0
    inputBinding:
      position: 103
      prefix: -f
  - id: fasta_list_file
    type:
      - 'null'
      - File
    doc: file with FASTA file names (alternative to listing file names explicitly
      in command line)
    inputBinding:
      position: 103
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: no of threads
    default: 28
    inputBinding:
      position: 103
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: verbosity level
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
