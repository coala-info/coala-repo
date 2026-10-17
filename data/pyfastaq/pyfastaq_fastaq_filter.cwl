cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - filter
label: pyfastaq_fastaq_filter
doc: "Filters a sequence file by sequence length and/or by name matching a regular expression\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of sequence to keep [0]"
    inputBinding:
      position: 1
      prefix: --min_length
  - id: max_length
    type:
      - 'null'
      - float
    doc: "Maximum length of sequence to keep [inf]"
    inputBinding:
      position: 2
      prefix: --max_length
  - id: regex
    type:
      - 'null'
      - string
    doc: "If given, only reads with a name matching the regular expression will be kept"
    inputBinding:
      position: 3
      prefix: --regex
  - id: ids_file
    type:
      - 'null'
      - File
    doc: "If given, only reads whose ID is in th given file will be used. One ID per line of file."
    inputBinding:
      position: 4
      prefix: --ids_file
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "Only keep sequences that do not match the filters"
    inputBinding:
      position: 5
      prefix: --invert
  - id: check_comments
    type:
      - 'null'
      - boolean
    doc: "Search the header comments also for the given regex. Can only be specified with --regex"
    inputBinding:
      position: 6
      prefix: --check_comments
  - id: mate_in
    type:
      - 'null'
      - File
    doc: "Name of mates input file. If used, must also provide --mate_out"
    inputBinding:
      position: 7
      prefix: --mate_in
  - id: mate_out
    type:
      - 'null'
      - string
    doc: "Name of mates output file"
    inputBinding:
      position: 8
      prefix: --mate_out
  - id: both_mates_pass
    type:
      - 'null'
      - boolean
    doc: "By default, if either mate passes filter, then both reads output. Use this flag to require that both reads of a pair pass the filter"
    inputBinding:
      position: 9
      prefix: --both_mates_pass
  - id: infile
    type: File
    doc: "Name of input file to be filtered"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
outputs:
  - id: mate_output
    type:
      - 'null'
      - File
    doc: "Name of mates output file"
    outputBinding:
      glob: $(inputs.mate_out)
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
