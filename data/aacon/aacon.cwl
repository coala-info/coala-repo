cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - aacon.jar
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
  - id: input_file
    type: File
    doc: Full path to the input FASTA or Clustal alignment file.
    inputBinding:
      position: 101
      prefix: -i=
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
  - id: smerfs_gap_threshold
    type:
      - 'null'
      - float
    doc: SMERFS Gap Threshold - a gap percentage cutoff (float > 0 and <= 1).
    inputBinding:
      position: 101
      prefix: -smerfsGT=
  - id: smerfs_window_width
    type:
      - 'null'
      - int
    doc: SMERFS Window Width parameter - must be an odd integer.
    inputBinding:
      position: 101
      prefix: -smerfsWW=
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs/cores to use. Defaults to all available processors.
    inputBinding:
      position: 101
      prefix: -t=
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Full path to the output file. If not provided, outputs to standard out.
    outputBinding:
      glob: $(inputs.output_file)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Full path to a file where program execution details/statistics are to 
      be listed.
    outputBinding:
      glob: $(inputs.stats_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aacon:1.1--hdfd78af_0
