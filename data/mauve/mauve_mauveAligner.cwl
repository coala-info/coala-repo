cwlVersion: v1.2
class: CommandLineTool
baseCommand: mauveAligner
label: mauve_mauveAligner
doc: "Aligns sequences using Mauve.\n\nTool homepage: http://darlinglab.org/mauve/"
inputs:
  - id: seq1_filename
    type: File
    doc: First sequence file
    inputBinding:
      position: 1
  - id: sml1_filename
    type: File
    doc: First sequence's suffix array file
    inputBinding:
      position: 2
  - id: seqN_filename
    type:
      type: array
      items: File
    doc: Subsequent sequence files
    inputBinding:
      position: 3
  - id: smlN_filename
    type:
      type: array
      items: File
    doc: Subsequent sequence's suffix array files
    inputBinding:
      position: 4
  - id: alignment_output_format
    type:
      - 'null'
      - string
    doc: Selects the output format for --alignment-output-dir
    inputBinding:
      position: 105
      prefix: --alignment-output-format
  - id: backbone_size
    type:
      - 'null'
      - int
    doc: Find stretches of backbone longer than the given number of b.p.
    inputBinding:
      position: 105
      prefix: --backbone-size
  - id: collinear
    type:
      - 'null'
      - boolean
    doc: Assume that input sequences are collinear--they have no rearrangements
    inputBinding:
      position: 105
      prefix: --collinear
  - id: eliminate_inclusions
    type:
      - 'null'
      - boolean
    doc: Eliminate linked inclusions in subset matches.
    inputBinding:
      position: 105
      prefix: --eliminate-inclusions
  - id: find_mums_only
    type:
      - 'null'
      - boolean
    doc: Find MUMs only, do not attempt to determine locally collinear blocks 
      (LCBs)
    inputBinding:
      position: 105
      prefix: --mums
  - id: id_matrix
    type:
      - 'null'
      - File
    doc: Generate LCB stats and write them to the specified file
    inputBinding:
      position: 105
      prefix: --id-matrix
  - id: island_size
    type:
      - 'null'
      - int
    doc: Find islands larger than the given number
    inputBinding:
      position: 105
      prefix: --island-size
  - id: lcb_input
    type:
      - 'null'
      - File
    doc: Use specified lcb file instead of constructing LCBs (skips LCB 
      generation)
    inputBinding:
      position: 105
      prefix: --lcb-input
  - id: lcb_match_input
    type:
      - 'null'
      - boolean
    doc: Indicates that the match input file contains matches that have been 
      clustered into LCBs
    inputBinding:
      position: 105
      prefix: --lcb-match-input
  - id: match_input
    type:
      - 'null'
      - File
    doc: Use specified match file instead of searching for matches
    inputBinding:
      position: 105
      prefix: --match-input
  - id: max_backbone_gap
    type:
      - 'null'
      - int
    doc: Allow backbone to be interrupted by gaps up to this length in b.p.
    inputBinding:
      position: 105
      prefix: --max-backbone-gap
  - id: max_extension_iterations
    type:
      - 'null'
      - int
    doc: Limit LCB extensions to this number of attempts, default is 4
    inputBinding:
      position: 105
      prefix: --max-extension-iterations
  - id: max_gapped_aligner_length
    type:
      - 'null'
      - int
    doc: Maximum number of base pairs to attempt aligning with the gapped 
      aligner
    inputBinding:
      position: 105
      prefix: --max-gapped-aligner-length
  - id: min_recursive_gap_length
    type:
      - 'null'
      - int
    doc: Minimum size of gaps that Mauve will perform recursive MUM anchoring on
      (Default is 200)
    inputBinding:
      position: 105
      prefix: --min-recursive-gap-length
  - id: no_gapped_alignment
    type:
      - 'null'
      - boolean
    doc: Don't perform a gapped alignment
    inputBinding:
      position: 105
      prefix: --no-gapped-alignment
  - id: no_lcb_extension
    type:
      - 'null'
      - boolean
    doc: If determining LCBs, don't attempt to extend the LCBs
    inputBinding:
      position: 105
      prefix: --no-lcb-extension
  - id: no_recursion
    type:
      - 'null'
      - boolean
    doc: Don't perform recursive anchor identification (implies 
      --no-gapped-alignment)
    inputBinding:
      position: 105
      prefix: --no-recursion
  - id: permutation_matrix_min_weight
    type:
      - 'null'
      - int
    doc: A permutation matrix will be written for every set of LCBs with weight 
      between this value and the value of --weight
    inputBinding:
      position: 105
      prefix: --permutation-matrix-min-weight
  - id: repeats
    type:
      - 'null'
      - boolean
    doc: Generates a repeat map. Only one sequence can be specified
    inputBinding:
      position: 105
      prefix: --repeats
  - id: scratch_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: For large genomes, use a directory for storage of temporary data. 
      Should be given two or more times to with different paths.
    inputBinding:
      position: 105
      prefix: --scratch-path
  - id: seed_size
    type:
      - 'null'
      - int
    doc: Initial seed match size, default is log_2( average seq. length )
    inputBinding:
      position: 105
      prefix: --seed-size
  - id: weight
    type:
      - 'null'
      - int
    doc: Minimum LCB weight in base pairs per sequence
    inputBinding:
      position: 105
      prefix: --weight
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. Prints to screen by default
    outputBinding:
      glob: $(inputs.output_file)
  - id: island_output
    type:
      - 'null'
      - File
    doc: Output islands the given file (requires --island-size)
    outputBinding:
      glob: $(inputs.island_output)
  - id: backbone_output
    type:
      - 'null'
      - File
    doc: Output islands the given file (requires --island-size)
    outputBinding:
      glob: $(inputs.backbone_output)
  - id: coverage_output
    type:
      - 'null'
      - File
    doc: Output a coverage list to the specified file (- for stdout)
    outputBinding:
      glob: $(inputs.coverage_output)
  - id: output_guide_tree
    type:
      - 'null'
      - File
    doc: Write out a guide tree to the designated file
    outputBinding:
      glob: $(inputs.output_guide_tree)
  - id: permutation_matrix_output
    type:
      - 'null'
      - File
    doc: Write out the LCBs as a signed permutation matrix to the given file
    outputBinding:
      glob: $(inputs.permutation_matrix_output)
  - id: alignment_output_dir
    type:
      - 'null'
      - Directory
    doc: Outputs a set of alignment files (one per LCB) to a given directory
    outputBinding:
      glob: $(inputs.alignment_output_dir)
  - id: output_alignment
    type:
      - 'null'
      - File
    doc: Write out an XMFA format alignment to the designated file
    outputBinding:
      glob: $(inputs.output_alignment)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/mauve:2.4.0.snapshot_2015_02_13--h2688d6d_0
