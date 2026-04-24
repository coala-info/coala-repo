cwlVersion: v1.2
class: CommandLineTool
baseCommand: squirrel
label: squirrel
doc: "Some QUIck Rearranging to Resolve Evolutionary Links\n\nTool homepage: https://github.com/aineniamh/squirrel"
inputs:
  - id: input
    type: File
    doc: Input fasta file of sequences to analyse.
    inputBinding:
      position: 1
  - id: additional_mask
    type:
      - 'null'
      - string
    doc: Masking additional sites provided as a csv. Needs columns `Maximum` and
      `Minimum` in 1-base.
    inputBinding:
      position: 102
      prefix: --additional-mask
  - id: asr_alignment
    type:
      - 'null'
      - File
    doc: Precomputed alignment file
    inputBinding:
      position: 102
      prefix: --asr-alignment
  - id: asr_state
    type:
      - 'null'
      - File
    doc: Precomputed ancestral states file
    inputBinding:
      position: 102
      prefix: --asr-state
  - id: asr_tree
    type:
      - 'null'
      - File
    doc: Precomputed tree with ancestral states reconstructed
    inputBinding:
      position: 102
      prefix: --asr-tree
  - id: assembly_refs
    type:
      - 'null'
      - string
    doc: References to check for `calls to reference` against.
    inputBinding:
      position: 102
      prefix: --assembly-refs
  - id: background_file
    type:
      - 'null'
      - File
    doc: Include this additional FASTA file as background to the phylogenetics.
    inputBinding:
      position: 102
      prefix: --background-file
  - id: binary_partition_mask
    type:
      - 'null'
      - boolean
    doc: Calculate and write binary partition mask
    inputBinding:
      position: 102
      prefix: --binary-partition-mask
  - id: bm_separate_dimers
    type:
      - 'null'
      - boolean
    doc: Write partition mask with 0 for non-apo, 1 for GA and 2 for TC target 
      sites
    inputBinding:
      position: 102
      prefix: --bm-separate-dimers
  - id: branch_reconstruction_file
    type:
      - 'null'
      - File
    doc: Reconstruction file for re-rendering the figure.
    inputBinding:
      position: 102
      prefix: --branch-reconstruction-file
  - id: clade
    type:
      - 'null'
      - string
    doc: Specify whether the alignment is primarily for `cladei` or `cladeii` 
      (can also specify a or b, e.g. `cladeia`, `cladeiib`). `split` will 
      separate input sequences into separate cladei and cladeii alignments. This
      will determine reference used for alignment, mask file and background set 
      used if `--include-background` flag used in conjunction with the 
      `--run-phylo` option.
    inputBinding:
      position: 102
      prefix: --clade
  - id: concatenate
    type:
      - 'null'
      - boolean
    doc: Concatenate coding sequences for each genome, separated by `NNN`.
    inputBinding:
      position: 102
      prefix: --concatenate
  - id: epi2me_outdir
    type:
      - 'null'
      - Directory
    doc: Output directory for report paths in epi2me.
    inputBinding:
      position: 102
      prefix: --epi2me-outdir
  - id: exclude
    type:
      - 'null'
      - File
    doc: Supply a csv file listing sequences that should be excluded from the 
      analysis.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: extract_cds
    type:
      - 'null'
      - boolean
    doc: Extract coding sequences based on coordinates in the reference
    inputBinding:
      position: 102
      prefix: --extract-cds
  - id: fig_height
    type:
      - 'null'
      - int
    doc: Overwrite tree figure default height.
    inputBinding:
      position: 102
      prefix: --fig-height
  - id: fig_width
    type:
      - 'null'
      - int
    doc: Overwrite tree figure default width.
    inputBinding:
      position: 102
      prefix: --fig-width
  - id: include_background
    type:
      - 'null'
      - boolean
    doc: Include a default background set of sequences for the phylogenetics 
      pipeline. The set will be determined by the `--clade` specified.
    inputBinding:
      position: 102
      prefix: --include-background
  - id: interactive_tree
    type:
      - 'null'
      - boolean
    doc: Create a separate interactive file built from R functions
    inputBinding:
      position: 102
      prefix: --interactive-tree
  - id: no_itr_mask
    type:
      - 'null'
      - boolean
    doc: Skip masking of end ITR.
    inputBinding:
      position: 102
      prefix: --no-itr-mask
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Skip masking of repetitive regions.
    inputBinding:
      position: 102
      prefix: --no-mask
  - id: no_temp
    type:
      - 'null'
      - boolean
    doc: Output all intermediate files, for dev purposes.
    inputBinding:
      position: 102
      prefix: --no-temp
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: outfile
    type:
      - 'null'
      - string
    doc: Optional output file name.
    inputBinding:
      position: 102
      prefix: --outfile
  - id: outgroups
    type:
      - 'null'
      - string
    doc: Specify which MPXV outgroup(s) in the alignment to use in the 
      phylogeny. These will get pruned out from the final tree.
    inputBinding:
      position: 102
      prefix: --outgroups
  - id: point_justify
    type:
      - 'null'
      - string
    doc: 'Justification of points for apobec3 reconstruction figure. Options: left,
      right.'
    inputBinding:
      position: 102
      prefix: --point-justify
  - id: point_style
    type:
      - 'null'
      - string
    doc: 'Shape of points for apobec3 reconstruction figure. Options: circle, square.'
    inputBinding:
      position: 102
      prefix: --point-style
  - id: run_apobec3_phylo
    type:
      - 'null'
      - boolean
    doc: Run phylogenetics & APOBEC3-mutation reconstruction pipeline
    inputBinding:
      position: 102
      prefix: --run-apobec3-phylo
  - id: run_phylo
    type:
      - 'null'
      - boolean
    doc: Run phylogenetics pipeline
    inputBinding:
      position: 102
      prefix: --run-phylo
  - id: seq_qc
    type:
      - 'null'
      - boolean
    doc: Flag potentially problematic SNPs and sequences.
    inputBinding:
      position: 102
      prefix: --seq-qc
  - id: sequence_mask
    type:
      - 'null'
      - string
    doc: Mask sites in specific sequences in the alignment as a csv, rather than
      the whole alignment column. Needs `sequence` and `site` (1-based) column.
    inputBinding:
      position: 102
      prefix: --sequence-mask
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Specify where you want the temp stuff to go.
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: tree_figure_only
    type:
      - 'null'
      - boolean
    doc: 'Re-render tree figure custom height and width arguments. Requires: tree
      file, branch reconstruction file, height, width.'
    inputBinding:
      position: 102
      prefix: --tree-figure-only
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Tree for re-rendering the figure.
    inputBinding:
      position: 102
      prefix: --tree-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print lots of stuff to screen
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squirrel:1.3.2--pyhdfd78af_0
stdout: squirrel.out
