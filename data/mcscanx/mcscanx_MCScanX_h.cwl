cwlVersion: v1.2
class: CommandLineTool
baseCommand: MCScanX_h
label: mcscanx_MCScanX_h
doc: "MCScanX_h prefix_fn [options]\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs:
  - id: prefix_fn
    type: string
    doc: prefix_fn
    inputBinding:
      position: 1
  - id: build_collinearity_file
    type:
      - 'null'
      - boolean
    doc: only builds the pairwise blocks (.collinearity file)
    inputBinding:
      position: 102
      prefix: -a
  - id: collinear_block_patterns
    type:
      - 'null'
      - int
    doc: patterns of collinear blocks. 0:intra- and inter-species (default); 
      1:intra-species; 2:inter-species
    default: 0
    inputBinding:
      position: 102
      prefix: -b
  - id: consider_homology_scores
    type:
      - 'null'
      - int
    doc: 'whether to consider homology scores. 0:not consider (default); 1: lower
      preferred; 2: higher preferred'
    default: 0
    inputBinding:
      position: 102
      prefix: -c
  - id: e_value
    type:
      - 'null'
      - float
    doc: E_VALUE, alignment significance
    default: '1e-05'
    inputBinding:
      position: 102
      prefix: -e
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: GAP_PENALTY, gap penalty
    default: -1
    inputBinding:
      position: 102
      prefix: -g
  - id: match_score
    type:
      - 'null'
      - string
    doc: MATCH_SCORE, final score=MATCH_SCORE+NUM_GAPS*GAP_PENALTY
    default: '50'
    inputBinding:
      position: 102
      prefix: -k
  - id: match_size
    type:
      - 'null'
      - int
    doc: MATCH_SIZE, number of genes required to call collinear blocks
    default: 5
    inputBinding:
      position: 102
      prefix: -s
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: MAX_GAPS, maximum gaps allowed
    default: 25
    inputBinding:
      position: 102
      prefix: -m
  - id: overlap_window
    type:
      - 'null'
      - int
    doc: OVERLAP_WINDOW, maximum distance (# of genes) to collapse BLAST matches
    default: 5
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_MCScanX_h.out
