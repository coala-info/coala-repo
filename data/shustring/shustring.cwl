cwlVersion: v1.2
class: CommandLineTool
baseCommand: shustring
label: shustring
doc: "compute shortest unique substrings\n\nTool homepage: https://github.com/CaliforniaEvolutionInsititue/Shustringer"
inputs:
  - id: fixed_word_length
    type:
      - 'null'
      - int
    doc: fixed word length NUM (with -a only)
    inputBinding:
      position: 101
      prefix: -f
  - id: hash_mode
    type:
      - 'null'
      - boolean
    doc: hash mode (requires -i, implies -n)
    inputBinding:
      position: 101
      prefix: -a
  - id: include_reverse_complement
    type:
      - 'null'
      - boolean
    doc: include reverse complement (implies -n)
    inputBinding:
      position: 101
      prefix: -r
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file
    default: stdin
    inputBinding:
      position: 101
      prefix: -i
  - id: max_shustring_length
    type:
      - 'null'
      - int
    doc: shustring length <= NUM (with -l only)
    inputBinding:
      position: 101
      prefix: -M
  - id: min_shustring_length
    type:
      - 'null'
      - int
    doc: shustring length >= NUM (with -l only)
    inputBinding:
      position: 101
      prefix: -m
  - id: nucleotide_sequence
    type:
      - 'null'
      - boolean
    doc: nucleotide sequence (DNA)
    inputBinding:
      position: 101
      prefix: -n
  - id: pattern
    type:
      - 'null'
      - string
    doc: print local shustrings for PATTERN
    inputBinding:
      position: 101
      prefix: -l
  - id: preserve_iupac
    type:
      - 'null'
      - boolean
    doc: preserve IUPAC nomenclature in nucleotide sequences
    inputBinding:
      position: 101
      prefix: -u
  - id: print_program_info
    type:
      - 'null'
      - boolean
    doc: print information about program
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not print shustrings
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shustring:2.6--h7b50bb2_8
