cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq filter
label: fastaq_filter
doc: "Filters a sequence file by sequence length and/or by name matching a regular
  expression\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file to be filtered
    inputBinding:
      position: 1
  - id: both_mates_pass
    type:
      - 'null'
      - boolean
    doc: By default, if either mate passes filter, then both reads output. Use 
      this flag to require that both reads of a pair pass the filter
    inputBinding:
      position: 102
      prefix: --both_mates_pass
  - id: ids_file
    type:
      - 'null'
      - File
    doc: If given, only reads whose ID is in th given file will be used. One ID 
      per line of file.
    inputBinding:
      position: 102
      prefix: --ids_file
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Only keep sequences that do not match the filters
    inputBinding:
      position: 102
      prefix: --invert
  - id: mate_in
    type:
      - 'null'
      - File
    doc: Name of mates input file. If used, must also provide --mate_out
    inputBinding:
      position: 102
      prefix: --mate_in
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length of sequence to keep
    default: inf
    inputBinding:
      position: 102
      prefix: --max_length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of sequence to keep
    default: 0
    inputBinding:
      position: 102
      prefix: --min_length
  - id: regex
    type:
      - 'null'
      - string
    doc: If given, only reads with a name matching the regular expression will 
      be kept
    inputBinding:
      position: 102
      prefix: --regex
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
  - id: mate_out
    type:
      - 'null'
      - File
    doc: Name of mates output file
    outputBinding:
      glob: $(inputs.mate_out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
