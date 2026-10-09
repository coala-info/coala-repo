cwlVersion: v1.2
class: CommandLineTool
baseCommand: MCScanX
label: mcscanx_MCScanX
doc: "MCScanX prefix_fn [options]\n\nTool homepage: https://github.com/wyp1125/MCScanX"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.prefix_fn).blast
        entry: $(inputs.blast_file)
        writable: true
      - entryname: $(inputs.prefix_fn).gff
        entry: $(inputs.gff_file)
        writable: true
  - class: InlineJavascriptRequirement
inputs:
  - id: prefix_fn
    type: string
    doc: Prefix of the input files (xyz for xyz.blast and xyz.gff)
    inputBinding:
      position: 1
  - id: blast_file
    type: File
    doc: BLAST tabular result (-outfmt 6) of all-vs-all protein search, staged as <prefix_fn>.blast
  - id: gff_file
    type: File
    doc: Gene position file (chromosome, gene, start, end), staged as <prefix_fn>.gff
  - id: build_pairwise_blocks
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
    inputBinding:
      position: 102
      prefix: -b
  - id: e_value
    type:
      - 'null'
      - float
    doc: E_VALUE, alignment significance
    inputBinding:
      position: 102
      prefix: -e
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: GAP_PENALTY, gap penalty
    inputBinding:
      position: 102
      prefix: -g
  - id: match_score
    type:
      - 'null'
      - float
    doc: MATCH_SCORE, final score=MATCH_SCORE+NUM_GAPS*GAP_PENALTY
    inputBinding:
      position: 102
      prefix: -k
  - id: match_size
    type:
      - 'null'
      - int
    doc: MATCH_SIZE, number of genes required to call a collinear block
    inputBinding:
      position: 102
      prefix: -s
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: MAX_GAPS, maximum gaps allowed
    inputBinding:
      position: 102
      prefix: -m
  - id: overlap_window
    type:
      - 'null'
      - int
    doc: OVERLAP_WINDOW, maximum distance (# of genes) to collapse BLAST matches
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: collinearity
    type:
      - 'null'
      - File
    doc: Collinear blocks (.collinearity file)
    outputBinding:
      glob: $(inputs.prefix_fn).collinearity
  - id: html
    type:
      - 'null'
      - Directory
    doc: HTML view of the collinear blocks per chromosome
    outputBinding:
      glob: $(inputs.prefix_fn).html
  - id: other_outputs
    type:
      type: array
      items: File
    doc: Other result files written with the prefix (.tandem, .synteny, ...)
    outputBinding:
      glob: ['$(inputs.prefix_fn).tandem', '$(inputs.prefix_fn).synteny']
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_MCScanX.out
