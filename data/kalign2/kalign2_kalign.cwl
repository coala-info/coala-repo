cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign2
label: kalign2_kalign
doc: "Kalign is free software. You can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software Foundation.\n\
  \nTool homepage: http://msa.sbc.su.se/cgi-bin/msa.cgi"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input file.
    inputBinding:
      position: 1
  - id: diff_feature_score
    type:
      - 'null'
      - float
    doc: Penalty for aligning different features
    inputBinding:
      position: 102
      prefix: -diff_feature_score
  - id: distance
    type:
      - 'null'
      - string
    doc: Distance method.
    inputBinding:
      position: 102
      prefix: -distance
  - id: feature
    type:
      - 'null'
      - string
    doc: Selects feature mode and specifies which features are to be used
    inputBinding:
      position: 102
      prefix: -feature
  - id: format
    type:
      - 'null'
      - string
    doc: The output format
    inputBinding:
      position: 102
      prefix: -format
  - id: gap_extension
    type:
      - 'null'
      - float
    doc: Gap extension penalty
    inputBinding:
      position: 102
      prefix: -gapextension
  - id: gap_inc
    type:
      - 'null'
      - float
    doc: Parameter increases gap penalties depending on the number of existing 
      gaps
    inputBinding:
      position: 102
      prefix: -gap_inc
  - id: gap_open
    type:
      - 'null'
      - float
    doc: Gap open penalty
    inputBinding:
      position: 102
      prefix: -gapopen
  - id: guide_tree
    type:
      - 'null'
      - string
    doc: Guide tree method.
    inputBinding:
      position: 102
      prefix: -guide-tree
  - id: infile
    type:
      - 'null'
      - File
    doc: The input file.
    inputBinding:
      position: 102
      prefix: -input
  - id: matrix_bonus
    type:
      - 'null'
      - float
    doc: A constant added to the substitution matrix.
    inputBinding:
      position: 102
      prefix: -matrix_bonus
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Print nothing to STDERR. Read nothing from STDIN
    inputBinding:
      position: 102
      prefix: -quiet
  - id: same_feature_score
    type:
      - 'null'
      - float
    doc: Score for aligning same features
    inputBinding:
      position: 102
      prefix: -same_feature_score
  - id: sort
    type:
      - 'null'
      - string
    doc: The order in which the sequences appear in the output alignment.
    inputBinding:
      position: 102
      prefix: -sort
  - id: terminal_gap_extension_penalty
    type:
      - 'null'
      - float
    doc: Terminal gap penalties
    inputBinding:
      position: 102
      prefix: -terminal_gap_extension_penalty
  - id: zcutoff
    type:
      - 'null'
      - float
    doc: Parameter used in the wu-manber based distance calculation
    inputBinding:
      position: 102
      prefix: -zcutoff
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file.
    outputBinding:
      glob: '*.out'
  - id: outfile
    type:
      - 'null'
      - File
    doc: The output file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalign2:2.04--h7b50bb2_8
