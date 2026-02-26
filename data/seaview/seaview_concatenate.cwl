cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_concatenate
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
      prefix: -NJ
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
      prefix: -align_algo
  - id: align_at_protein_level
    type:
      - 'null'
      - boolean
    doc: translate and align input sequences and reproduce alignment at DNA 
      level.
    inputBinding:
      position: 102
      prefix: -align_at_protein_level
  - id: align_extra_opts
    type:
      - 'null'
      - string
    doc: additional options to use when running the alignment algorithm
    inputBinding:
      position: 102
      prefix: -align_extra_opts
  - id: align_output_format
    type:
      - 'null'
      - string
    doc: format of the concatenated alignment (mase, phylip, clustal, msf, 
      fasta, or nexus)
    inputBinding:
      position: 102
      prefix: -output_format
  - id: align_output_format_align
    type:
      - 'null'
      - string
    doc: format of the output alignment (mase, phylip, clustal, msf, fasta, or 
      nexus)
    inputBinding:
      position: 102
      prefix: -output_format
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: writes n bootstrap replicates of the input alignment to the output file
    inputBinding:
      position: 102
      prefix: -bootstrap
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
      prefix: -by_rank
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
      prefix: -def_site_selection
  - id: def_species_group
    type:
      - 'null'
      - string
    doc: 'create a species group of given name and members (species group members
      are expressed with their ranks as in this example: 3-8,12,19)'
    inputBinding:
      position: 102
      prefix: -def_species_group
  - id: del_gap_only_sites
    type:
      - 'null'
      - boolean
    doc: remove all gap-only sites from alignment (don't use the -sites option)
    inputBinding:
      position: 102
      prefix: -del_gap_only_sites
  - id: distance
    type:
      - 'null'
      - string
    doc: computes the tree with a distance method using dist_name (observed, JC,
      K2P, logdet, Ka, Ks, Poisson or Kimura)
    inputBinding:
      position: 102
      prefix: -distance
  - id: distance_matrix
    type:
      - 'null'
      - File
    doc: don't compute the tree, but write to fname the matrix of pairwise 
      distances
    inputBinding:
      position: 102
      prefix: -distance_matrix
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
      prefix: -gaps_as_unknown
  - id: gblocks
    type:
      - 'null'
      - boolean
    doc: create under the name 'Gblocks' a set of blocks of conserved sites with
      the Gblocks program (requires the nexus or mase output formats)
    inputBinding:
      position: 102
      prefix: -gblocks
  - id: gblocks_allow_gaps_in_blocks
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
      prefix: -jumbles
  - id: no_terminal_stop
    type:
      - 'null'
      - boolean
    doc: translate terminal stop codons as a gap (with -translate option)
    inputBinding:
      position: 102
      prefix: -no_terminal_stop
  - id: nogaps
    type:
      - 'null'
      - boolean
    doc: remove all gap-containing sites before computations
    inputBinding:
      position: 102
      prefix: -nogaps
  - id: output_format
    type:
      - 'null'
      - string
    doc: format of the converted alignment file (mase, phylip, clustal, msf, 
      fasta, or nexus)
    inputBinding:
      position: 102
      prefix: -output_format
  - id: parsimony
    type:
      - 'null'
      - boolean
    doc: compute the tree by the parsimony method
    inputBinding:
      position: 102
      prefix: -parsimony
  - id: record_partition
    type:
      - 'null'
      - boolean
    doc: record the locations of the concatenated pieces in the final 
      concatenate
    inputBinding:
      position: 102
      prefix: -record_partition
  - id: replicates
    type:
      - 'null'
      - int
    doc: use n bootstrap replicates to compute tree branch support
    inputBinding:
      position: 102
      prefix: -replicates
  - id: search
    type:
      - 'null'
      - string
    doc: controls how much rearrangement is done to find better trees (DNA 
      parsimony only)
    inputBinding:
      position: 102
      prefix: -search
  - id: sites
    type:
      - 'null'
      - string
    doc: use the named selection of sites from the input alignment
    inputBinding:
      position: 102
      prefix: -sites
  - id: species
    type:
      - 'null'
      - string
    doc: use the named group of species from the input alignment
    inputBinding:
      position: 102
      prefix: -species
  - id: translate
    type:
      - 'null'
      - boolean
    doc: translate input sequences to protein before outputting them (don't use 
      -sites)
    inputBinding:
      position: 102
      prefix: -translate
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the converted alignment (default is built from 
      input filename)
    outputBinding:
      glob: $(inputs.output_file)
  - id: align_output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the concatenated alignment (default is built from 
      input filename)
    outputBinding:
      glob: $(inputs.align_output_file)
  - id: align_output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the output alignment (default is built from input 
      filename)
    outputBinding:
      glob: $(inputs.align_output_file)
  - id: build_tree_output_file
    type:
      - 'null'
      - File
    doc: use fname as name of the output tree
    outputBinding:
      glob: $(inputs.build_tree_output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
