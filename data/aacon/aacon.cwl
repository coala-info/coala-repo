cwlVersion: v1.2
class: CommandLineTool
baseCommand: aacon
label: aacon
doc: "AA Conservation calculates conservation of amino acids in multiple sequence
  alignments using 17 different conservation scores and the SMERFS scoring algorithm.\n\
  \nTool homepage: https://www.compbio.dundee.ac.uk/aacon/"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Format of the results in the output file (RESULT_WITH_ALIGNMENT or 
      RESULT_NO_ALIGNMENT).
    inputBinding:
      position: 101
      prefix: -f=
      separate: false
  - id: gap_characters
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of gap characters. If provided, must include all 
      accepted gaps.
    inputBinding:
      position: 101
      prefix: -g=
      separate: false
      itemSeparator: ','
  - id: input_file
    type: File
    doc: Full path to the input FASTA or Clustal alignment file.
    inputBinding:
      position: 101
      prefix: -i=
      separate: false
  - id: methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of method names (e.g., KABAT, JORES, GERSTEIN). If
      no method is specified, all are assumed.
    inputBinding:
      position: 101
      prefix: -m=
      separate: false
      itemSeparator: ','
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Causes the results to be normalized to values between 0 and 1.
    inputBinding:
      position: 101
      prefix: -n
  - id: smerfs_column_score
    type:
      - 'null'
      - string
    doc: SMERFS Column Score algorithm (MID_SCORE or MAX_SCORE).
    inputBinding:
      position: 101
      prefix: -smerfsCS=
      separate: false
  - id: smerfs_gap_threshold
    type:
      - 'null'
      - float
    doc: SMERFS Gap Threshold - a gap percentage cutoff (float > 0 and <= 1).
    inputBinding:
      position: 101
      prefix: -smerfsGT=
      separate: false
  - id: smerfs_window_width
    type:
      - 'null'
      - int
    doc: SMERFS Window Width parameter - must be an odd integer.
    inputBinding:
      position: 101
      prefix: -smerfsWW=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs/cores to use. Defaults to all available processors.
    inputBinding:
      position: 101
      prefix: -t=
      separate: false
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Full path to the output file. Without it, results go to standard out.
    inputBinding:
      position: 102
      prefix: -o=
      separate: false
  - id: stats_file_path
    type:
      - 'null'
      - string
    doc: Full path to a file where program execution details are listed. Without
      it, no execution statistics are produced.
    inputBinding:
      position: 103
      prefix: -d=
      separate: false
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Full path to the output file. If not provided, outputs to standard out.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Full path to a file where program execution details/statistics are to 
      be listed.
    outputBinding:
      glob: $(inputs.stats_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aacon:1.1--hdfd78af_0
