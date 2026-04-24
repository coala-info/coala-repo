cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressiveMauve
label: progressivemauve_progressiveMauve
doc: "Aligns multiple sequences.\n\nTool homepage: http://darlinglab.org/mauve/user-guide/progressivemauve.html"
inputs:
  - id: seq_filename
    type: File
    doc: Filename of sequences to align (all genomes in a single file)
    inputBinding:
      position: 1
  - id: seq_filenames
    type:
      type: array
      items: File
    doc: Filenames of sequences to align (one file per genome)
    inputBinding:
      position: 2
  - id: apply_backbone
    type:
      - 'null'
      - File
    doc: Read an existing sequence alignment in XMFA format and apply backbone 
      statistics to it
    inputBinding:
      position: 103
      prefix: --apply-backbone
  - id: bp_dist_estimate_min_score
    type:
      - 'null'
      - int
    doc: Minimum LCB score for estimating pairwise breakpoint distance
    inputBinding:
      position: 103
      prefix: --bp-dist-estimate-min-score
  - id: coding_seeds
    type:
      - 'null'
      - boolean
    doc: Use coding pattern seeds. Useful to generate matches coding regions 
      with 3rd codon position degeneracy.
    inputBinding:
      position: 103
      prefix: --coding-seeds
  - id: collinear
    type:
      - 'null'
      - boolean
    doc: Assume that input sequences are collinear--they have no rearrangements
    inputBinding:
      position: 103
      prefix: --collinear
  - id: conservation_distance_scale
    type:
      - 'null'
      - float
    doc: Scale conservation distances by this amount. Defaults to 0.5
    inputBinding:
      position: 103
      prefix: --conservation-distance-scale
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode (perform internal consistency checks--very slow)
    inputBinding:
      position: 103
      prefix: --debug
  - id: disable_backbone
    type:
      - 'null'
      - boolean
    doc: Disable backbone detection
    inputBinding:
      position: 103
      prefix: --disable-backbone
  - id: disable_cache
    type:
      - 'null'
      - boolean
    doc: Disable recursive anchor search cacheing to workaround a crash bug
    inputBinding:
      position: 103
      prefix: --disable-cache
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: Gap extend penalty
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Gap open penalty
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: hmm_identity
    type:
      - 'null'
      - float
    doc: Expected level of sequence identity among pairs of sequences, ranging 
      between 0 and 1
    inputBinding:
      position: 103
      prefix: --hmm-identity
  - id: hmm_p_go_homologous
    type:
      - 'null'
      - float
    doc: Probability of transitioning from the unrelated to the homologous state
    inputBinding:
      position: 103
      prefix: --hmm-p-go-homologous
  - id: hmm_p_go_unrelated
    type:
      - 'null'
      - float
    doc: Probability of transitioning from the homologous to the unrelated state
    inputBinding:
      position: 103
      prefix: --hmm-p-go-unrelated
  - id: input_guide_tree
    type:
      - 'null'
      - File
    doc: A phylogenetic guide tree in NEWICK format that describes the order in 
      which sequences will be aligned
    inputBinding:
      position: 103
      prefix: --input-guide-tree
  - id: input_id_matrix
    type:
      - 'null'
      - File
    doc: An identity matrix describing similarity among all pairs of input 
      sequences/alignments
    inputBinding:
      position: 103
      prefix: --input-id-matrix
  - id: island_gap_size
    type:
      - 'null'
      - int
    doc: Alignment gaps above this size in nucleotides are considered to be 
      islands
    inputBinding:
      position: 103
      prefix: --island-gap-size
  - id: match_input
    type:
      - 'null'
      - File
    doc: Use specified match file instead of searching for matches
    inputBinding:
      position: 103
      prefix: --match-input
  - id: max_breakpoint_distance_scale
    type:
      - 'null'
      - float
    doc: Set the maximum weight scaling by breakpoint distance. Defaults to 0.5
    inputBinding:
      position: 103
      prefix: --max-breakpoint-distance-scale
  - id: max_gapped_aligner_length
    type:
      - 'null'
      - int
    doc: Maximum number of base pairs to attempt aligning with the gapped 
      aligner
    inputBinding:
      position: 103
      prefix: --max-gapped-aligner-length
  - id: mem_clean
    type:
      - 'null'
      - boolean
    doc: Set this to true when debugging memory allocations
    inputBinding:
      position: 103
      prefix: --mem-clean
  - id: min_scaled_penalty
    type:
      - 'null'
      - int
    doc: Minimum breakpoint penalty after scaling the penalty by expected 
      divergence
    inputBinding:
      position: 103
      prefix: --min-scaled-penalty
  - id: mums
    type:
      - 'null'
      - boolean
    doc: Find MUMs only, do not attempt to determine locally collinear blocks 
      (LCBs)
    inputBinding:
      position: 103
      prefix: --mums
  - id: muscle_args
    type:
      - 'null'
      - string
    doc: Additional command-line options for MUSCLE. Any quotes should be 
      escaped with a backslash
    inputBinding:
      position: 103
      prefix: --muscle-args
  - id: no_recursion
    type:
      - 'null'
      - boolean
    doc: Disable recursive anchor search
    inputBinding:
      position: 103
      prefix: --no-recursion
  - id: no_weight_scaling
    type:
      - 'null'
      - boolean
    doc: Don't scale LCB weights by conservation distance and breakpoint 
      distance
    inputBinding:
      position: 103
      prefix: --no-weight-scaling
  - id: profile
    type:
      - 'null'
      - File
    doc: Read an existing sequence alignment in XMFA format and align it to 
      other sequences or alignments
    inputBinding:
      position: 103
      prefix: --profile
  - id: repeat_penalty
    type:
      - 'null'
      - string
    doc: Sets whether the repeat scores go negative or go to zero for highly 
      repetitive sequences. Default is negative.
    inputBinding:
      position: 103
      prefix: --repeat-penalty
  - id: scoring_scheme
    type:
      - 'null'
      - string
    doc: Selects the anchoring score function. Default is extant sum-of-pairs 
      (sp).
    inputBinding:
      position: 103
      prefix: --scoring-scheme
  - id: scratch_path_1
    type:
      - 'null'
      - Directory
    doc: Designate a path that can be used for temporary data storage. Two or 
      more paths should be specified.
    inputBinding:
      position: 103
      prefix: --scratch-path-1
  - id: scratch_path_2
    type:
      - 'null'
      - Directory
    doc: Designate a path that can be used for temporary data storage. Two or 
      more paths should be specified.
    inputBinding:
      position: 103
      prefix: --scratch-path-2
  - id: seed_family
    type:
      - 'null'
      - boolean
    doc: Use a family of spaced seeds to improve sensitivity
    inputBinding:
      position: 103
      prefix: --seed-family
  - id: seed_weight
    type:
      - 'null'
      - int
    doc: Use the specified seed weight for calculating initial anchors
    inputBinding:
      position: 103
      prefix: --seed-weight
  - id: skip_gapped_alignment
    type:
      - 'null'
      - boolean
    doc: Do not perform gapped alignment
    inputBinding:
      position: 103
      prefix: --skip-gapped-alignment
  - id: skip_refinement
    type:
      - 'null'
      - boolean
    doc: Do not perform iterative refinement
    inputBinding:
      position: 103
      prefix: --skip-refinement
  - id: solid_seeds
    type:
      - 'null'
      - boolean
    doc: Use solid seeds. Do not permit substitutions in anchor matches.
    inputBinding:
      position: 103
      prefix: --solid-seeds
  - id: substitution_matrix
    type:
      - 'null'
      - File
    doc: Nucleotide substitution matrix in NCBI format
    inputBinding:
      position: 103
      prefix: --substitution-matrix
  - id: weight
    type:
      - 'null'
      - int
    doc: Minimum pairwise LCB score
    inputBinding:
      position: 103
      prefix: --weight
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name. Prints to screen by default
    outputBinding:
      glob: $(inputs.output)
  - id: backbone_output
    type:
      - 'null'
      - File
    doc: Backbone output file name (optional)
    outputBinding:
      glob: $(inputs.backbone_output)
  - id: output_guide_tree
    type:
      - 'null'
      - File
    doc: Write out the guide tree used for alignment to a file
    outputBinding:
      glob: $(inputs.output_guide_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progressivemauve:snapshot_2015_02_13--0
