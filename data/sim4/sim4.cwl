cwlVersion: v1.2
class: CommandLineTool
baseCommand: sim4
label: sim4
doc: "sim4 is a program to align a cDNA sequence with a genomic DNA sequence, allowing
  for introns.\n\nTool homepage: https://github.com/sb-ai-lab/Sim4Rec"
inputs:
  - id: cdna_file
    type: File
    doc: cDNA sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: genomic_file
    type: File
    doc: Genomic DNA sequence file (FASTA format)
    inputBinding:
      position: 2
  - id: cutoff_score
    type:
      - 'null'
      - float
    doc: Cutoff score for reporting matches
    inputBinding:
      position: 103
      prefix: E
  - id: diagonal_distance
    type:
      - 'null'
      - int
    doc: Maximum diagonal distance for grouping MSPs
    inputBinding:
      position: 103
      prefix: D
  - id: extension_threshold
    type:
      - 'null'
      - int
    doc: Threshold for extending hits
    inputBinding:
      position: 103
      prefix: X
  - id: max_matches
    type:
      - 'null'
      - int
    doc: Maximum number of matches to report
    inputBinding:
      position: 103
      prefix: n
  - id: msp_threshold
    type:
      - 'null'
      - int
    doc: Threshold for MSPs in the first pass
    inputBinding:
      position: 103
      prefix: K
  - id: msp_threshold_second
    type:
      - 'null'
      - int
    doc: Threshold for MSPs in the second pass
    inputBinding:
      position: 103
      prefix: C
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Output format (0: default, 1: alignment, 2: both, 3: exon boundaries, 4:
      lav-like)'
    inputBinding:
      position: 103
      prefix: A
  - id: poly_a_info
    type:
      - 'null'
      - int
    doc: Use poly-A tail information (1) or not (0)
    inputBinding:
      position: 103
      prefix: P
  - id: search_both_strands
    type:
      - 'null'
      - int
    doc: Search both strands (1) or only the forward strand (0)
    inputBinding:
      position: 103
      prefix: B
  - id: search_direction
    type:
      - 'null'
      - int
    doc: 'Search direction (0: forward, 1: reverse, 2: both)'
    inputBinding:
      position: 103
      prefix: R
  - id: show_alignments
    type:
      - 'null'
      - int
    doc: Show alignments (1) or not (0)
    inputBinding:
      position: 103
      prefix: H
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for the first stage of the search
    inputBinding:
      position: 103
      prefix: W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sim4:v0.0.20121010-5-deb_cv1
stdout: sim4.out
