cwlVersion: v1.2
class: CommandLineTool
baseCommand: python /usr/local/bin/TeloSearchLR.py
label: telosearchlr_TeloSearchLR.py
doc: "TELOomeric repeat motif SEARCH using Long Reads\n\nTool homepage: https://github.com/gchchung/TeloSearchLR"
inputs:
  - id: K_value
    type: int
    doc: longest repeat period (≥k) to consider by TideHunter
    inputBinding:
      position: 101
      prefix: --K_value
  - id: Mth_pattern
    type: int
    doc: rank of the least frequent motif to plot (≥m)
    inputBinding:
      position: 101
      prefix: --Mth_pattern
  - id: cores
    type:
      - 'null'
      - int
    doc: number of threads to use for TideHunter
    inputBinding:
      position: 101
      prefix: --cores
  - id: exhaustive_mode
    type:
      - 'null'
      - boolean
    doc: enable "exhaustive mode", motifs ranked by period AND occupancy
    inputBinding:
      position: 101
      prefix: --exhaustive
  - id: fasta_file
    type: File
    doc: long-read sequencing library file name
    inputBinding:
      position: 101
      prefix: --fasta
  - id: k_value
    type: int
    doc: shortest repeat period (>0) to consider by TideHunter
    inputBinding:
      position: 101
      prefix: --k_value
  - id: mth_pattern
    type: int
    doc: rank of the most frequent motif to plot (>0)
    inputBinding:
      position: 101
      prefix: --mth_pattern
  - id: num_of_nucleotides
    type: int
    doc: number of nucleotides to plot motif occupancy
    inputBinding:
      position: 101
      prefix: --num_of_nucleotides
  - id: single_motif_mode
    type:
      - 'null'
      - string
    doc: enable "single-motif mode", specify the motif whose occupancy is to be 
      plotted
    inputBinding:
      position: 101
      prefix: --single_motif
  - id: terminal_nucleotides
    type:
      - 'null'
      - int
    doc: terminal number of nucleotides to consider for ranking motif occupancy
    inputBinding:
      position: 101
      prefix: --terminal
  - id: tidehunter_output
    type: string
    doc: a TideHunter (>=v1.5.4) tabular output
    inputBinding:
      position: 101
      prefix: --TideHunter
  - id: tidehunter_path
    type:
      - 'null'
      - string
    doc: path of TideHunter (if not already in $PATH)
    inputBinding:
      position: 101
      prefix: --path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telosearchlr:1.0.1--pyhdfd78af_0
stdout: telosearchlr_TeloSearchLR.py.out
