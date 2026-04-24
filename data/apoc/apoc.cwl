cwlVersion: v1.2
class: CommandLineTool
baseCommand: apoc
label: apoc
doc: "Large-scale structural alignment and comparison of protein pockets\n\nTool homepage:
  http://cssb.biology.gatech.edu/APoc"
inputs:
  - id: pdbfile1
    type: File
    doc: First PDB file for comparison
    inputBinding:
      position: 1
  - id: pdbfile2
    type: File
    doc: Second PDB file for comparison
    inputBinding:
      position: 2
  - id: alignment_printout
    type:
      - 'null'
      - int
    doc: 'Alignment printout: 0 - none, 1 - concise, 2 - detailed (default).'
    inputBinding:
      position: 103
      prefix: -v
  - id: global_alignment
    type:
      - 'null'
      - int
    doc: 'Global structure alignment: 1 - enable (default), 0 - disable.'
    inputBinding:
      position: 103
      prefix: -fa
  - id: min_pocket_residues
    type:
      - 'null'
      - int
    doc: Minimal number of pocket residues.
    inputBinding:
      position: 103
      prefix: -plen
  - id: min_pocket_volume
    type:
      - 'null'
      - int
    doc: Minimal pocket volume in grid points.
    inputBinding:
      position: 103
      prefix: -pvol
  - id: normalize_average
    type:
      - 'null'
      - boolean
    doc: Normalize the score by the average size of two structures.
    inputBinding:
      position: 103
      prefix: -a
  - id: normalize_fixed_length
    type:
      - 'null'
      - int
    doc: Normalize the score with a fixed length specified by num.
    inputBinding:
      position: 103
      prefix: -L
  - id: normalize_max
    type:
      - 'null'
      - boolean
    doc: Normalize the score by the maximum size of two structures.
    inputBinding:
      position: 103
      prefix: -c
  - id: normalize_min
    type:
      - 'null'
      - boolean
    doc: Normalize the score by the minimum size of two structures.
    inputBinding:
      position: 103
      prefix: -b
  - id: pdb_block
    type:
      - 'null'
      - File
    doc: Load a block of concatenated pdb files.
    inputBinding:
      position: 103
      prefix: -block
  - id: query_list
    type:
      - 'null'
      - File
    doc: Provide a list of queries (targets) to compare in a file.
    inputBinding:
      position: 103
      prefix: -lq
  - id: query_pockets
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of pockets in the second (query) structure for comparison.
    inputBinding:
      position: 103
      prefix: -pq
  - id: scoring_metric
    type:
      - 'null'
      - string
    doc: 'Similarity scoring metric: tm (TM-score), ps (PS-score, default).'
    inputBinding:
      position: 103
      prefix: -m
  - id: sequence_order_dependent
    type:
      - 'null'
      - boolean
    doc: Restrict to sequence-order-dependent alignment. Default no restriction.
    inputBinding:
      position: 103
      prefix: -sod
  - id: template_list
    type:
      - 'null'
      - File
    doc: Provide a list of templates to compare in a file.
    inputBinding:
      position: 103
      prefix: -lt
  - id: template_pockets
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of pockets in the first (template) structure for comparison.
    inputBinding:
      position: 103
      prefix: -pt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apoc:1b16--0
stdout: apoc.out
