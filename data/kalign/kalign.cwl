cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign
doc: "Kalign 2: fast multiple sequence alignment (guide tree from Wu-Manber or pairwise distances, then progressive alignment).\n\nTool homepage: https://github.com/TimoLassmann/kalign"
inputs:
  - id: gap_open
    type:
      - 'null'
      - float
    doc: "Gap open penalty"
    inputBinding:
      position: 1
      prefix: -gapopen
  - id: gap_extension
    type:
      - 'null'
      - float
    doc: "Gap extension penalty"
    inputBinding:
      position: 2
      prefix: -gapextension
  - id: terminal_gap_extension_penalty
    type:
      - 'null'
      - float
    doc: "Terminal gap penalties"
    inputBinding:
      position: 3
      prefix: -tgpe
  - id: matrix_bonus
    type:
      - 'null'
      - float
    doc: "A constant added to the substitution matrix."
    inputBinding:
      position: 4
      prefix: -bonus
  - id: sort
    type:
      - 'null'
      - string
    doc: "The order in which the sequences appear in the output alignment: input, tree, gaps"
    inputBinding:
      position: 5
      prefix: -sort
  - id: feature
    type:
      - 'null'
      - string
    doc: "Selects feature mode and specifies which features are to be used: e.g. all, maxplp, STRUCT, PFAM-A...."
    inputBinding:
      position: 6
      prefix: -feature
  - id: same_feature_score
    type:
      - 'null'
      - float
    doc: "Score for aligning same features"
    inputBinding:
      position: 7
      prefix: -same_feature_score
  - id: diff_feature_score
    type:
      - 'null'
      - float
    doc: "Penalty for aligning different features"
    inputBinding:
      position: 8
      prefix: -diff_feature_score
  - id: distance
    type:
      - 'null'
      - string
    doc: "Distance method: wu, pair"
    inputBinding:
      position: 9
      prefix: -distance
  - id: guide_tree
    type:
      - 'null'
      - string
    doc: "Guide tree method: nj, upgma"
    inputBinding:
      position: 10
      prefix: -tree
  - id: zcutoff
    type:
      - 'null'
      - float
    doc: "Parameter used in the wu-manber based distance calculation"
    inputBinding:
      position: 11
      prefix: -zcutoff
  - id: input_file
    type: File
    doc: "The input file."
    inputBinding:
      position: 12
      prefix: -input
  - id: output_path
    type:
      - 'null'
      - string
    doc: "The output file."
    inputBinding:
      position: 13
      prefix: -output
  - id: gap_inc
    type:
      - 'null'
      - float
    doc: "Parameter increases gap penalties depending on the number of existing gaps"
    inputBinding:
      position: 14
      prefix: -gap_inc
  - id: format
    type:
      - 'null'
      - string
    doc: "The output format: fasta, msf, aln, clu, macsim"
    inputBinding:
      position: 15
      prefix: -format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Print nothing to STDERR. Read nothing from STDIN"
    inputBinding:
      position: 16
      prefix: -quiet
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Alignment written to the output file"
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output (the alignment when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kalign:v1-2.0320110620-5-deb_cv1
stdout: kalign.out
