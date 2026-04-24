cwlVersion: v1.2
class: CommandLineTool
baseCommand: edlib-aligner
label: edlib-aligner
doc: "Align sequences from queries.fasta to target.fasta\n\nTool homepage: https://github.com/Martinsos/edlib/"
inputs:
  - id: queries_fasta
    type: File
    doc: FASTA file containing query sequences
    inputBinding:
      position: 1
  - id: target_fasta
    type: File
    doc: FASTA file containing the target sequence
    inputBinding:
      position: 2
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: 'Alignment mode that will be used. [default: NW]'
    inputBinding:
      position: 103
      prefix: -m
  - id: alignment_path_format
    type:
      - 'null'
      - string
    doc: 'Format that will be used to print alignment path, can be used only with
      -p. NICE will give visually attractive format, CIG_STD will give standard cigar
      format and CIG_EXT will give extended cigar format. [default: NICE]'
    inputBinding:
      position: 103
      prefix: -f
  - id: discard_threshold
    type:
      - 'null'
      - int
    doc: 'Sequences with score > K will be discarded. Smaller k, faster calculation.
      If -1, no sequences will be discarded. [default: -1]'
    inputBinding:
      position: 103
      prefix: -k
  - id: find_alignment_path
    type:
      - 'null'
      - boolean
    doc: If specified, alignment path will be found and printed. This may 
      significantly slow down the calculation.
    inputBinding:
      position: 103
      prefix: -p
  - id: find_start_locations
    type:
      - 'null'
      - boolean
    doc: If specified, start locations will be found and printed. Each start 
      location corresponds to one end location. This may somewhat slow down the 
      calculation, but is still faster then finding alignment path and does not 
      consume any extra memory.
    inputBinding:
      position: 103
      prefix: -l
  - id: num_best_sequences
    type:
      - 'null'
      - int
    doc: 'Score will be calculated only for N best sequences (best = with smallest
      score). If N = 0 then all sequences will be calculated. Specifying small N can
      make total calculation much faster. [default: 0]'
    inputBinding:
      position: 103
      prefix: -n
  - id: repeat_count
    type:
      - 'null'
      - int
    doc: 'Core part of calculation will be repeated N times. This is useful only for
      performance measurement, when single execution is too short to measure. [default:
      1]'
    inputBinding:
      position: 103
      prefix: -r
  - id: silent_mode
    type:
      - 'null'
      - boolean
    doc: If specified, there will be no score or alignment output (silent mode).
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/edlib-aligner:v1.2.4-1-deb_cv1
stdout: edlib-aligner.out
