cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressiveMauve
label: progressivemauve_progressiveMauve
doc: "Aligns multiple genome sequences (progressiveMauve).\n\nTool homepage: http://darlinglab.org/mauve/user-guide/progressivemauve.html"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.sequences.map(function(f){ return {"entry": f, "writable": true}; }))'
inputs:
  - id: sequences
    type: File[]
    doc: "Sequence files to align: one file per genome, or a single file with all genomes"
    inputBinding:
      position: 10
  - id: island_gap_size
    type:
      - 'null'
      - int
    doc: "Alignment gaps above this size in nucleotides are considered to be islands [20]"
    inputBinding:
      position: 2
      prefix: --island-gap-size=
      separate: false
  - id: profile
    type:
      - 'null'
      - File
    doc: "(Not yet implemented) Read an existing sequence alignment in XMFA format and align it to other sequences or alignments"
    inputBinding:
      position: 2
      prefix: --profile=
      separate: false
  - id: apply_backbone
    type:
      - 'null'
      - File
    doc: "Read an existing sequence alignment in XMFA format and apply backbone statistics to it"
    inputBinding:
      position: 2
      prefix: --apply-backbone=
      separate: false
  - id: disable_backbone
    type:
      - 'null'
      - boolean
    doc: "Disable backbone detection"
    inputBinding:
      position: 2
      prefix: --disable-backbone
  - id: mums
    type:
      - 'null'
      - boolean
    doc: "Find MUMs only, do not attempt to determine locally collinear blocks (LCBs)"
    inputBinding:
      position: 2
      prefix: --mums
  - id: seed_weight
    type:
      - 'null'
      - int
    doc: "Use the specified seed weight for calculating initial anchors"
    inputBinding:
      position: 2
      prefix: --seed-weight=
      separate: false
  - id: output
    type:
      - 'null'
      - string
    default: alignment.xmfa
    doc: "Output file name. Prints to screen by default"
    inputBinding:
      position: 2
      prefix: --output=
      separate: false
  - id: backbone_output
    type:
      - 'null'
      - string
    doc: "Backbone output file name (optional)."
    inputBinding:
      position: 2
      prefix: --backbone-output=
      separate: false
  - id: match_input
    type:
      - 'null'
      - File
    doc: "Use specified match file instead of searching for matches"
    inputBinding:
      position: 2
      prefix: --match-input=
      separate: false
  - id: input_id_matrix
    type:
      - 'null'
      - File
    doc: "An identity matrix describing similarity among all pairs of input sequences/alignments"
    inputBinding:
      position: 2
      prefix: --input-id-matrix=
      separate: false
  - id: max_gapped_aligner_length
    type:
      - 'null'
      - int
    doc: "Maximum number of base pairs to attempt aligning with the gapped aligner"
    inputBinding:
      position: 2
      prefix: --max-gapped-aligner-length=
      separate: false
  - id: input_guide_tree
    type:
      - 'null'
      - File
    doc: "A phylogenetic guide tree in NEWICK format that describes the order in which sequences will be aligned"
    inputBinding:
      position: 2
      prefix: --input-guide-tree=
      separate: false
  - id: output_guide_tree
    type:
      - 'null'
      - string
    doc: "Write out the guide tree used for alignment to a file"
    inputBinding:
      position: 2
      prefix: --output-guide-tree=
      separate: false
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Run in debug mode (perform internal consistency checks--very slow)"
    inputBinding:
      position: 2
      prefix: --debug
  - id: scratch_path_1
    type:
      - 'null'
      - string
    doc: "Designate a path that can be used for temporary data storage. Two or more paths should be specified."
    inputBinding:
      position: 2
      prefix: --scratch-path-1=
      separate: false
  - id: scratch_path_2
    type:
      - 'null'
      - string
    doc: "Designate a path that can be used for temporary data storage. Two or more paths should be specified."
    inputBinding:
      position: 2
      prefix: --scratch-path-2=
      separate: false
  - id: collinear
    type:
      - 'null'
      - boolean
    doc: "Assume that input sequences are collinear--they have no rearrangements"
    inputBinding:
      position: 2
      prefix: --collinear
  - id: scoring_scheme
    type:
      - 'null'
      - string
    doc: "Selects the anchoring score function: ancestral, sp_ancestral or sp (default: extant sum-of-pairs, sp)."
    inputBinding:
      position: 2
      prefix: --scoring-scheme=
      separate: false
  - id: no_weight_scaling
    type:
      - 'null'
      - boolean
    doc: "Don't scale LCB weights by conservation distance and breakpoint distance"
    inputBinding:
      position: 2
      prefix: --no-weight-scaling
  - id: max_breakpoint_distance_scale
    type:
      - 'null'
      - float
    doc: "Set the maximum weight scaling by breakpoint distance, number in [0,1]. Defaults to 0.5"
    inputBinding:
      position: 2
      prefix: --max-breakpoint-distance-scale=
      separate: false
  - id: conservation_distance_scale
    type:
      - 'null'
      - float
    doc: "Scale conservation distances by this amount, number in [0,1]. Defaults to 0.5"
    inputBinding:
      position: 2
      prefix: --conservation-distance-scale=
      separate: false
  - id: muscle_args
    type:
      - 'null'
      - string
    doc: "Additional command-line options for MUSCLE (in quotes)"
    inputBinding:
      position: 2
      prefix: --muscle-args=
      separate: false
  - id: skip_refinement
    type:
      - 'null'
      - boolean
    doc: "Do not perform iterative refinement"
    inputBinding:
      position: 2
      prefix: --skip-refinement
  - id: skip_gapped_alignment
    type:
      - 'null'
      - boolean
    doc: "Do not perform gapped alignment"
    inputBinding:
      position: 2
      prefix: --skip-gapped-alignment
  - id: bp_dist_estimate_min_score
    type:
      - 'null'
      - int
    doc: "Minimum LCB score for estimating pairwise breakpoint distance"
    inputBinding:
      position: 2
      prefix: --bp-dist-estimate-min-score=
      separate: false
  - id: mem_clean
    type:
      - 'null'
      - boolean
    doc: "Set this to true when debugging memory allocations"
    inputBinding:
      position: 2
      prefix: --mem-clean
  - id: gap_open
    type:
      - 'null'
      - int
    doc: "Gap open penalty"
    inputBinding:
      position: 2
      prefix: --gap-open=
      separate: false
  - id: repeat_penalty
    type:
      - 'null'
      - string
    doc: "Sets whether the repeat scores go negative or go to zero for highly repetitive sequences (negative or zero). Default is negative."
    inputBinding:
      position: 2
      prefix: --repeat-penalty=
      separate: false
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: "Gap extend penalty"
    inputBinding:
      position: 2
      prefix: --gap-extend=
      separate: false
  - id: substitution_matrix
    type:
      - 'null'
      - File
    doc: "Nucleotide substitution matrix in NCBI format"
    inputBinding:
      position: 2
      prefix: --substitution-matrix=
      separate: false
  - id: weight
    type:
      - 'null'
      - int
    doc: "Minimum pairwise LCB score"
    inputBinding:
      position: 2
      prefix: --weight=
      separate: false
  - id: min_scaled_penalty
    type:
      - 'null'
      - int
    doc: "Minimum breakpoint penalty after scaling the penalty by expected divergence"
    inputBinding:
      position: 2
      prefix: --min-scaled-penalty=
      separate: false
  - id: hmm_p_go_homologous
    type:
      - 'null'
      - float
    doc: "Probability of transitioning from the unrelated to the homologous state [0.00001]"
    inputBinding:
      position: 2
      prefix: --hmm-p-go-homologous=
      separate: false
  - id: hmm_p_go_unrelated
    type:
      - 'null'
      - float
    doc: "Probability of transitioning from the homologous to the unrelated state [0.000000001]"
    inputBinding:
      position: 2
      prefix: --hmm-p-go-unrelated=
      separate: false
  - id: hmm_identity
    type:
      - 'null'
      - float
    doc: "Expected level of sequence identity among pairs of sequences, ranging between 0 and 1 [0.7]"
    inputBinding:
      position: 2
      prefix: --hmm-identity=
      separate: false
  - id: seed_family
    type:
      - 'null'
      - boolean
    doc: "Use a family of spaced seeds to improve sensitivity"
    inputBinding:
      position: 2
      prefix: --seed-family
  - id: solid_seeds
    type:
      - 'null'
      - boolean
    doc: "Use solid seeds. Do not permit substitutions in anchor matches."
    inputBinding:
      position: 2
      prefix: --solid-seeds
  - id: coding_seeds
    type:
      - 'null'
      - boolean
    doc: "Use coding pattern seeds. Useful to generate matches coding regions with 3rd codon position degeneracy."
    inputBinding:
      position: 2
      prefix: --coding-seeds
  - id: disable_cache
    type:
      - 'null'
      - boolean
    doc: "Disable recursive anchor search cacheing to workaround a crash bug"
    inputBinding:
      position: 2
      prefix: --disable-cache
  - id: no_recursion
    type:
      - 'null'
      - boolean
    doc: "Disable recursive anchor search"
    inputBinding:
      position: 2
      prefix: --no-recursion
outputs:
  - id: alignment
    type: File
    doc: Alignment in XMFA format
    outputBinding:
      glob: $(inputs.output)
  - id: backbone_file
    type:
      - 'null'
      - File
    doc: Backbone file
    outputBinding:
      glob: $(inputs.backbone_output)
  - id: guide_tree_file
    type:
      - 'null'
      - File
    doc: Guide tree (Newick)
    outputBinding:
      glob: $(inputs.output_guide_tree)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progressivemauve:snapshot_2015_02_13--0
stdout: progressivemauve_progressiveMauve.out
