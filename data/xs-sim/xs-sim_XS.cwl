cwlVersion: v1.2
class: CommandLineTool
baseCommand: XS
label: xs-sim_XS
doc: "XS is a simulator for sequencing data.\n\nTool homepage: https://github.com/pratas/xs"
inputs:
  - id: custom_quality_template
    type:
      - 'null'
      - string
    doc: custom template ascii alphabet
    inputBinding:
      position: 101
      prefix: -qc
  - id: dynamic_line_size
    type:
      - 'null'
      - string
    doc: dynamic line (bases/quality scores) size
    inputBinding:
      position: 101
      prefix: -ld
  - id: exclude_dna_bases
    type:
      - 'null'
      - boolean
    doc: excludes the use of DNA bases from output
    inputBinding:
      position: 101
      prefix: -ed
  - id: exclude_headers
    type:
      - 'null'
      - boolean
    doc: excludes the use of headers from output
    inputBinding:
      position: 101
      prefix: -eh
  - id: exclude_newline_on_dna_base_limit
    type:
      - 'null'
      - boolean
    doc: excludes '\n' when DNA bases line size is reached
    inputBinding:
      position: 101
      prefix: -edb
  - id: exclude_optional_headers
    type:
      - 'null'
      - boolean
    doc: excludes the use of optional headers (+) from output
    inputBinding:
      position: 101
      prefix: -eo
  - id: exclude_quality_scores
    type:
      - 'null'
      - boolean
    doc: excludes the use of quality scores from output
    inputBinding:
      position: 101
      prefix: -es
  - id: generation_seed
    type:
      - 'null'
      - int
    doc: generation seed
    inputBinding:
      position: 101
      prefix: -s
  - id: header_format
    type:
      - 'null'
      - int
    doc: 'header format: 1=Length appendix, 2=Pair End'
    inputBinding:
      position: 101
      prefix: -hf
  - id: instrument_name
    type:
      - 'null'
      - string
    doc: the unique instrument name (use n= before name)
    inputBinding:
      position: 101
      prefix: -i
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: 'repeats: mutation frequency'
    inputBinding:
      position: 101
      prefix: -rm
  - id: number_of_reads
    type:
      - 'null'
      - int
    doc: number of reads per file
    inputBinding:
      position: 101
      prefix: -n
  - id: quality_scores_file
    type:
      - 'null'
      - File
    doc: 'load file: mean, standard deviation (when: -qt 2)'
    inputBinding:
      position: 101
      prefix: -qf
  - id: quality_scores_type
    type:
      - 'null'
      - int
    doc: 'quality scores distribution: 1=uniform, 2=gaussian'
    inputBinding:
      position: 101
      prefix: -qt
  - id: repeats_max_size
    type:
      - 'null'
      - int
    doc: 'repeats: maximum size'
    inputBinding:
      position: 101
      prefix: -ra
  - id: repeats_min_size
    type:
      - 'null'
      - int
    doc: 'repeats: minimum size'
    inputBinding:
      position: 101
      prefix: -ri
  - id: repeats_number
    type:
      - 'null'
      - int
    doc: 'repeats: number'
    default: 0
    inputBinding:
      position: 101
      prefix: -rn
  - id: sequencing_type
    type:
      - 'null'
      - int
    doc: 'type: 1=Roche-454, 2=Illumina, 3=ABI SOLiD, 4=Ion Torrent'
    inputBinding:
      position: 101
      prefix: -t
  - id: static_line_size
    type:
      - 'null'
      - int
    doc: static line (bases/quality scores) size
    inputBinding:
      position: 101
      prefix: -ls
  - id: symbols_frequency
    type:
      - 'null'
      - string
    doc: symbols frequency
    inputBinding:
      position: 101
      prefix: -f
  - id: use_reverse_complement_repeats
    type:
      - 'null'
      - boolean
    doc: 'repeats: use reverse complement repeats'
    inputBinding:
      position: 101
      prefix: -rr
  - id: use_same_header
    type:
      - 'null'
      - boolean
    doc: use the same header in third line of the read
    inputBinding:
      position: 101
      prefix: -o
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: simulated output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xs-sim:2--hec16e2b_0
