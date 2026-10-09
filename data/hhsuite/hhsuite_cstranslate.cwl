cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstranslate
label: hhsuite_cstranslate
doc: "Translate a sequence/alignment into an abstract state alphabet.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: infile
    type: File
    doc: Input file with alignment or sequence
    inputBinding:
      position: 101
      prefix: -i
  - id: outfile_path
    type: string
    doc: Output file for generated abstract state sequence (the tool default is <infile>.as, beside the input)
    inputBinding:
      position: 102
      prefix: -o
  - id: append_path
    type:
      - 'null'
      - string
    doc: Append generated abstract state sequence to this file
    inputBinding:
      position: 103
      prefix: -a
  - id: informat
    type:
      - 'null'
      - string
    doc: 'Input format: prf, seq, fas, a2m, a3m or ca3m (def=auto)'
    inputBinding:
      position: 103
      prefix: -I
  - id: outformat
    type:
      - 'null'
      - string
    doc: 'Outformat: seq (abstract state sequence) or prf (profile) (def=seq)'
    inputBinding:
      position: 103
      prefix: -O
  - id: match_assign
    type:
      - 'null'
      - float
    doc: 'Make all FASTA columns with less than X% gaps match columns (def: make columns with residue in first sequence match columns)'
    inputBinding:
      position: 103
      prefix: -M
  - id: alphabet
    type:
      - 'null'
      - File
    doc: Abstract state alphabet consisting of exactly 219 states (def=internal)
    inputBinding:
      position: 103
      prefix: -A
  - id: context_data
    type:
      - 'null'
      - File
    doc: Add context-specific pseudocounts using given context-data (def=internal)
    inputBinding:
      position: 103
      prefix: -D
  - id: pc_admix
    type:
      - 'null'
      - float
    doc: Pseudocount admix for context-specific pseudocounts (def=0.90)
    inputBinding:
      position: 103
      prefix: -x
  - id: pc_ali
    type:
      - 'null'
      - float
    doc: Constant in pseudocount calculation for alignments (def=12.0)
    inputBinding:
      position: 103
      prefix: -c
  - id: weight
    type:
      - 'null'
      - float
    doc: Weight of abstract state column in emission calculation (def=1000.00)
    inputBinding:
      position: 103
      prefix: -w
  - id: ffindex
    type:
      - 'null'
      - boolean
    doc: Read from -i <ffindex>, write to -o <ffindex> (do not include _ca3m suffix for ca3m informat); enables openmp if possible (def=off)
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: outfile
    type: File
    doc: abstract state sequence or profile
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: append_file
    type:
      - 'null'
      - File
    doc: file the abstract state sequence was appended to
    outputBinding:
      glob: $(inputs.append_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
