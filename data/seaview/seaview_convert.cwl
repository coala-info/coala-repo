cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_convert
doc: "seaview [options] [alignment-or-tree-file]\n\nTool homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs:
  - id: alignment_or_tree_file
    type:
      - 'null'
      - File
    doc: an optional sequence alignment or tree file to be read (always the last
      argument)
    inputBinding:
      position: 1
  - id: NJ
    type:
      - 'null'
      - boolean
    doc: compute the distance tree by the Neighbor-Joining method (default is 
      BioNJ)
    inputBinding:
      position: 102
  - id: align
    type:
      - 'null'
      - boolean
    doc: align an input sequence file (no window creation)
    inputBinding:
      position: 102
      prefix: -align
  - id: align_algo
    type:
      - 'null'
      - int
    doc: rank (in seaview from 0) of alignment algorithm, otherwise use 
      seaview's default alignment algorithm
    inputBinding:
      position: 102
  - id: align_at_protein_level
    type:
      - 'null'
      - boolean
    doc: translate and align input sequences and reproduce alignment at DNA 
      level.
    inputBinding:
      position: 102
  - id: align_extra_opts
    type:
      - 'null'
      - string
    doc: additional options to use when running the alignment algorithm
    inputBinding:
      position: 102
  - id: align_output_format
    type:
      - 'null'
      - string
    doc: format of the output alignment (mase, phylip, clustal, msf, fasta, or 
      nexus)
    inputBinding:
      position: 102
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: writes n bootstrap replicates of the input alignment to the output file
    inputBinding:
      position: 102
  - id: build_tree
    type:
      - 'null'
      - boolean
    doc: compute a phylogenetic tree from an input alignment file (no window 
      creation)
    inputBinding:
      position: 102
      prefix: -build_tree
  - id: by_rank
    type:
      - 'null'
      - boolean
    doc: identify sequences by their rank in alignments (rather than by their 
      name)
    inputBinding:
      position: 102
  - id: concatenate
    type:
      - 'null'
      - boolean
    doc: concatenate alignment(s) to the end of an input alignment (no window 
      creation)
    inputBinding:
      position: 102
      prefix: -concatenate
  - id: concatenate_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: name(s) of alignment files to add at the end of the input alignment
    inputBinding:
      position: 102
      prefix: -concatenate
  - id: convert
    type:
      - 'null'
      - boolean
    doc: convert an input alignment to another format (no window creation)
    inputBinding:
      position: 102
      prefix: -convert
  - id: def_site_selection
    type:
      - 'null'
      - string
    doc: 'create a selection of sites of given name and endpoints (site selection
      endpoints are expressed as in this example: 10-200,305,310-342)'
    inputBinding:
      position: 102
  - id: def_species_group
    type:
      - 'null'
      - string
    doc: 'create a species group of given name and members (species group members
      are expressed with their ranks as in this example: 3-8,12,19)'
    inputBinding:
      position: 102
  - id: del_gap_only_sites
    type:
      - 'null'
      - boolean
    doc: remove all gap-only sites from alignment (don't use the -sites option)
    inputBinding:
      position: 102
  - id: distance
    type:
      - 'null'
      - string
    doc: computes the tree with a distance method using dist_name (observed, JC,
      K2P, logdet, Ka, Ks, Poisson or Kimura)
    inputBinding:
      position: 102
  - id: distance_matrix
    type:
      - 'null'
      - File
    doc: don't compute the tree, but write to fname the matrix of pairwise 
      distances
    inputBinding:
      position: 102
  - id: fast
    type:
      - 'null'
      - boolean
    doc: sequences will be displayed faster but less smoothly
    inputBinding:
      position: 102
      prefix: -fast
  - id: fontsize
    type:
      - 'null'
      - int
    doc: font size used for the tree plot or alignment windows
    inputBinding:
      position: 102
      prefix: -fontsize
  - id: gaps_as_unknown
    type:
      - 'null'
      - boolean
    doc: encode gaps as unknown character state (parsimony only)
    inputBinding:
      position: 102
  - id: gblocks
    type:
      - 'null'
      - boolean
    doc: create under the name 'Gblocks' a set of blocks of conserved sites with
      the Gblocks program (requires the nexus or mase output formats)
    inputBinding:
      position: 102
  - id: gblocks_allow_gaps
    type:
      - 'null'
      - boolean
    doc: allow gaps within final blocks
    inputBinding:
      position: 102
      prefix: -b5
  - id: gblocks_allow_smaller_blocks
    type:
      - 'null'
      - boolean
    doc: allow smaller final blocks
    inputBinding:
      position: 102
      prefix: -b4
  - id: gblocks_less_strict_flanking
    type:
      - 'null'
      - boolean
    doc: less strict flanking positions
    inputBinding:
      position: 102
      prefix: -b2
  - id: gblocks_no_many_contiguous_nonconserved
    type:
      - 'null'
      - boolean
    doc: don't allow many contiguous nonconserved positions
    inputBinding:
      position: 102
      prefix: -b3
  - id: jumbles
    type:
      - 'null'
      - int
    doc: jumble sequence order n times (parsimony only)
    inputBinding:
      position: 102
  - id: no_terminal_stop
    type:
      - 'null'
      - boolean
    doc: translate terminal stop codons as a gap (with -translate option)
    inputBinding:
      position: 102
  - id: nogaps
    type:
      - 'null'
      - boolean
    doc: remove all gap-containing sites before computations
    inputBinding:
      position: 102
  - id: output_format
    type:
      - 'null'
      - string
    doc: format of the converted alignment file (mase, phylip, clustal, msf, 
      fasta, or nexus)
    inputBinding:
      position: 102
  - id: parsimony
    type:
      - 'null'
      - boolean
    doc: compute the tree by the parsimony method
    inputBinding:
      position: 102
  - id: record_partition
    type:
      - 'null'
      - boolean
    doc: record the locations of the concatenated pieces in the final 
      concatenate
    inputBinding:
      position: 102
  - id: replicates
    type:
      - 'null'
      - int
    doc: use n bootstrap replicates to compute tree branch support
    inputBinding:
      position: 102
  - id: search
    type:
      - 'null'
      - string
    doc: controls how much rearrangement is done to find better trees (DNA 
      parsimony only)
    inputBinding:
      position: 102
  - id: sites
    type:
      - 'null'
      - string
    doc: use the named selection of sites from the input alignment
    inputBinding:
      position: 102
  - id: species
    type:
      - 'null'
      - string
    doc: use the named group of species from the input alignment
    inputBinding:
      position: 102
  - id: translate
    type:
      - 'null'
      - boolean
    doc: translate input sequences to protein before outputting them (don't use 
      -sites)
    inputBinding:
      position: 102
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the converted alignment (default is built from 
      input filename)
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_to_stdout
    type:
      - 'null'
      - File
    doc: write the output alignment to standard output
    outputBinding:
      glob: $(inputs.output_to_stdout)
  - id: align_output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the output alignment (default is built from input 
      filename)
    outputBinding:
      glob: $(inputs.align_output_file)
  - id: align_output_to_stdout
    type:
      - 'null'
      - File
    doc: write the output alignment to standard output
    outputBinding:
      glob: $(inputs.align_output_to_stdout)
  - id: tree_output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the output tree
    outputBinding:
      glob: $(inputs.tree_output_file)
  - id: tree_output_to_stdout
    type:
      - 'null'
      - File
    doc: write the output tree to standard output
    outputBinding:
      glob: $(inputs.tree_output_to_stdout)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
