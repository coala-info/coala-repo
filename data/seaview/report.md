# seaview CWL Generation Report

## seaview_convert

### Tool Description
seaview [options] [alignment-or-tree-file]

### Metadata
- **Docker Image**: biocontainers/seaview:v1-4.7-1-deb_cv1
- **Homepage**: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seaview/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022
- **Stars**: N/A
### Original Help Text
```text
Usage:
seaview [options] [alignment-or-tree-file]
where alignment-or-tree-file is an optional sequence alignment or tree file to be read (always the last argument) and options are:
-h            display all program options and exit
-fontsize n   font size used for the tree plot or alignment windows
-fast         sequences will be displayed faster but less smoothly
     Options for non-interactive usage driven by command-line arguments
(Use exactly one for a non-interactive seaview run. Add any sub-option described below)
-convert      convert an input alignment to another format (no window creation)
-concatenate  concatenate alignment(s) to the end of an input alignment (no window creation)
-align        align an input sequence file (no window creation)
-build_tree   compute a phylogenetic tree from an input alignment file (no window creation)

           Sub-options for -convert
           Use '-' as last argument to read alignment from standard input
-output_format fmt    format of the converted alignment file (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the converted alignment (default is built from input filename)
-o -          write the output alignment to standard output
-translate    translate input sequences to protein before outputting them (don't use -sites)
-no_terminal_stop   translate terminal stop codons as a gap (with -translate option)
-del_gap_only_sites  remove all gap-only sites from alignment (don't use the -sites option)
-def_species_group group_name,group_member_ranks   create a species group of given name and members
                  (species group members are expressed with their ranks as in this example: 3-8,12,19)
-def_site_selection name,endpoints   create a selection of sites of given name and endpoints
                  (site selection endpoints are expressed as in this example: 10-200,305,310-342)
-gblocks      create under the name 'Gblocks' a set of blocks of conserved sites with the Gblocks program
                  (requires the nexus or mase output formats)
      -gblocks-specific options:
              -b4 allow smaller final blocks
              -b5 allow gaps within final blocks 
              -b2 less strict flanking positions 
              -b3 don't allow many contiguous nonconserved positions
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 
-bootstrap n    writes n bootstrap replicates of the input alignment to the output file 

           Sub-options for -concatenate 
           Use '-' as last argument to read alignment from standard input
-concatenate align1,...    name(s) of alignment files to add at the end of the input alignment
-by_rank      identify sequences by their rank in alignments (rather than by their name)
-record_partition record the locations of the concatenated pieces in the final concatenate
-output_format fmt    format of the concatenated alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the concatenated alignment (default is built from input filename)
-o -          write the concatenated alignment to standard output

           Sub-options for -align 
           Use '-' as last argument to read sequence file from standard input
-align_algo n  rank (in seaview from 0) of alignment algorithm, otherwise use seaview's default alignment algorithm
-align_extra_opts "option1 ..."  additional options to use when running the alignment algorithm
-align_at_protein_level  translate and align input sequences and reproduce alignment at DNA level.
-output_format fmt    format of the output alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the output alignment (default is built from input filename)
-o -          write the output alignment to standard output

           Sub-options for -build_tree (either -distance or -parsimony is required)
           Use '-' as last argument to read alignment from standard input
-o fname      use fname as name of the output tree
-o -          write the output tree to standard output
-distance dist_name   computes the tree with a distance method using dist_name (observed, JC, K2P, logdet, Ka, Ks, Poisson or Kimura)
-distance_matrix fname  don't compute the tree, but write to fname the matrix of pairwise distances
-NJ           compute the distance tree by the Neighbor-Joining method (default is BioNJ)
-parsimony    compute the tree by the parsimony method 
-search more|less|one  controls how much rearrangement is done to find better trees (DNA parsimony only)
-nogaps       remove all gap-containing sites before computations
-replicates n use n bootstrap replicates to compute tree branch support
-jumbles n    jumble sequence order n times (parsimony only)
-gaps_as_unknown  encode gaps as unknown character state (parsimony only)
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 

See http://doua.prabi.fr/software/seaview_data/seaview#Program%20arguments for more details
```


## seaview_concatenate

### Tool Description
seaview [options] [alignment-or-tree-file]

### Metadata
- **Docker Image**: biocontainers/seaview:v1-4.7-1-deb_cv1
- **Homepage**: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:
seaview [options] [alignment-or-tree-file]
where alignment-or-tree-file is an optional sequence alignment or tree file to be read (always the last argument) and options are:
-h            display all program options and exit
-fontsize n   font size used for the tree plot or alignment windows
-fast         sequences will be displayed faster but less smoothly
     Options for non-interactive usage driven by command-line arguments
(Use exactly one for a non-interactive seaview run. Add any sub-option described below)
-convert      convert an input alignment to another format (no window creation)
-concatenate  concatenate alignment(s) to the end of an input alignment (no window creation)
-align        align an input sequence file (no window creation)
-build_tree   compute a phylogenetic tree from an input alignment file (no window creation)

           Sub-options for -convert
           Use '-' as last argument to read alignment from standard input
-output_format fmt    format of the converted alignment file (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the converted alignment (default is built from input filename)
-o -          write the output alignment to standard output
-translate    translate input sequences to protein before outputting them (don't use -sites)
-no_terminal_stop   translate terminal stop codons as a gap (with -translate option)
-del_gap_only_sites  remove all gap-only sites from alignment (don't use the -sites option)
-def_species_group group_name,group_member_ranks   create a species group of given name and members
                  (species group members are expressed with their ranks as in this example: 3-8,12,19)
-def_site_selection name,endpoints   create a selection of sites of given name and endpoints
                  (site selection endpoints are expressed as in this example: 10-200,305,310-342)
-gblocks      create under the name 'Gblocks' a set of blocks of conserved sites with the Gblocks program
                  (requires the nexus or mase output formats)
      -gblocks-specific options:
              -b4 allow smaller final blocks
              -b5 allow gaps within final blocks 
              -b2 less strict flanking positions 
              -b3 don't allow many contiguous nonconserved positions
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 
-bootstrap n    writes n bootstrap replicates of the input alignment to the output file 

           Sub-options for -concatenate 
           Use '-' as last argument to read alignment from standard input
-concatenate align1,...    name(s) of alignment files to add at the end of the input alignment
-by_rank      identify sequences by their rank in alignments (rather than by their name)
-record_partition record the locations of the concatenated pieces in the final concatenate
-output_format fmt    format of the concatenated alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the concatenated alignment (default is built from input filename)
-o -          write the concatenated alignment to standard output

           Sub-options for -align 
           Use '-' as last argument to read sequence file from standard input
-align_algo n  rank (in seaview from 0) of alignment algorithm, otherwise use seaview's default alignment algorithm
-align_extra_opts "option1 ..."  additional options to use when running the alignment algorithm
-align_at_protein_level  translate and align input sequences and reproduce alignment at DNA level.
-output_format fmt    format of the output alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the output alignment (default is built from input filename)
-o -          write the output alignment to standard output

           Sub-options for -build_tree (either -distance or -parsimony is required)
           Use '-' as last argument to read alignment from standard input
-o fname      use fname as name of the output tree
-o -          write the output tree to standard output
-distance dist_name   computes the tree with a distance method using dist_name (observed, JC, K2P, logdet, Ka, Ks, Poisson or Kimura)
-distance_matrix fname  don't compute the tree, but write to fname the matrix of pairwise distances
-NJ           compute the distance tree by the Neighbor-Joining method (default is BioNJ)
-parsimony    compute the tree by the parsimony method 
-search more|less|one  controls how much rearrangement is done to find better trees (DNA parsimony only)
-nogaps       remove all gap-containing sites before computations
-replicates n use n bootstrap replicates to compute tree branch support
-jumbles n    jumble sequence order n times (parsimony only)
-gaps_as_unknown  encode gaps as unknown character state (parsimony only)
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 

See http://doua.prabi.fr/software/seaview_data/seaview#Program%20arguments for more details
```


## seaview_align

### Tool Description
seaview [options] [alignment-or-tree-file]
where alignment-or-tree-file is an optional sequence alignment or tree file to be read (always the last argument) and options are:

### Metadata
- **Docker Image**: biocontainers/seaview:v1-4.7-1-deb_cv1
- **Homepage**: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:
seaview [options] [alignment-or-tree-file]
where alignment-or-tree-file is an optional sequence alignment or tree file to be read (always the last argument) and options are:
-h            display all program options and exit
-fontsize n   font size used for the tree plot or alignment windows
-fast         sequences will be displayed faster but less smoothly
     Options for non-interactive usage driven by command-line arguments
(Use exactly one for a non-interactive seaview run. Add any sub-option described below)
-convert      convert an input alignment to another format (no window creation)
-concatenate  concatenate alignment(s) to the end of an input alignment (no window creation)
-align        align an input sequence file (no window creation)
-build_tree   compute a phylogenetic tree from an input alignment file (no window creation)

           Sub-options for -convert
           Use '-' as last argument to read alignment from standard input
-output_format fmt    format of the converted alignment file (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the converted alignment (default is built from input filename)
-o -          write the output alignment to standard output
-translate    translate input sequences to protein before outputting them (don't use -sites)
-no_terminal_stop   translate terminal stop codons as a gap (with -translate option)
-del_gap_only_sites  remove all gap-only sites from alignment (don't use the -sites option)
-def_species_group group_name,group_member_ranks   create a species group of given name and members
                  (species group members are expressed with their ranks as in this example: 3-8,12,19)
-def_site_selection name,endpoints   create a selection of sites of given name and endpoints
                  (site selection endpoints are expressed as in this example: 10-200,305,310-342)
-gblocks      create under the name 'Gblocks' a set of blocks of conserved sites with the Gblocks program
                  (requires the nexus or mase output formats)
      -gblocks-specific options:
              -b4 allow smaller final blocks
              -b5 allow gaps within final blocks 
              -b2 less strict flanking positions 
              -b3 don't allow many contiguous nonconserved positions
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 
-bootstrap n    writes n bootstrap replicates of the input alignment to the output file 

           Sub-options for -concatenate 
           Use '-' as last argument to read alignment from standard input
-concatenate align1,...    name(s) of alignment files to add at the end of the input alignment
-by_rank      identify sequences by their rank in alignments (rather than by their name)
-record_partition record the locations of the concatenated pieces in the final concatenate
-output_format fmt    format of the concatenated alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the concatenated alignment (default is built from input filename)
-o -          write the concatenated alignment to standard output

           Sub-options for -align 
           Use '-' as last argument to read sequence file from standard input
-align_algo n  rank (in seaview from 0) of alignment algorithm, otherwise use seaview's default alignment algorithm
-align_extra_opts "option1 ..."  additional options to use when running the alignment algorithm
-align_at_protein_level  translate and align input sequences and reproduce alignment at DNA level.
-output_format fmt    format of the output alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the output alignment (default is built from input filename)
-o -          write the output alignment to standard output

           Sub-options for -build_tree (either -distance or -parsimony is required)
           Use '-' as last argument to read alignment from standard input
-o fname      use fname as name of the output tree
-o -          write the output tree to standard output
-distance dist_name   computes the tree with a distance method using dist_name (observed, JC, K2P, logdet, Ka, Ks, Poisson or Kimura)
-distance_matrix fname  don't compute the tree, but write to fname the matrix of pairwise distances
-NJ           compute the distance tree by the Neighbor-Joining method (default is BioNJ)
-parsimony    compute the tree by the parsimony method 
-search more|less|one  controls how much rearrangement is done to find better trees (DNA parsimony only)
-nogaps       remove all gap-containing sites before computations
-replicates n use n bootstrap replicates to compute tree branch support
-jumbles n    jumble sequence order n times (parsimony only)
-gaps_as_unknown  encode gaps as unknown character state (parsimony only)
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 

See http://doua.prabi.fr/software/seaview_data/seaview#Program%20arguments for more details
```


## seaview_build_tree

### Tool Description
seaview [options] [alignment-or-tree-file]

### Metadata
- **Docker Image**: biocontainers/seaview:v1-4.7-1-deb_cv1
- **Homepage**: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:
seaview [options] [alignment-or-tree-file]
where alignment-or-tree-file is an optional sequence alignment or tree file to be read (always the last argument) and options are:
-h            display all program options and exit
-fontsize n   font size used for the tree plot or alignment windows
-fast         sequences will be displayed faster but less smoothly
     Options for non-interactive usage driven by command-line arguments
(Use exactly one for a non-interactive seaview run. Add any sub-option described below)
-convert      convert an input alignment to another format (no window creation)
-concatenate  concatenate alignment(s) to the end of an input alignment (no window creation)
-align        align an input sequence file (no window creation)
-build_tree   compute a phylogenetic tree from an input alignment file (no window creation)

           Sub-options for -convert
           Use '-' as last argument to read alignment from standard input
-output_format fmt    format of the converted alignment file (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the converted alignment (default is built from input filename)
-o -          write the output alignment to standard output
-translate    translate input sequences to protein before outputting them (don't use -sites)
-no_terminal_stop   translate terminal stop codons as a gap (with -translate option)
-del_gap_only_sites  remove all gap-only sites from alignment (don't use the -sites option)
-def_species_group group_name,group_member_ranks   create a species group of given name and members
                  (species group members are expressed with their ranks as in this example: 3-8,12,19)
-def_site_selection name,endpoints   create a selection of sites of given name and endpoints
                  (site selection endpoints are expressed as in this example: 10-200,305,310-342)
-gblocks      create under the name 'Gblocks' a set of blocks of conserved sites with the Gblocks program
                  (requires the nexus or mase output formats)
      -gblocks-specific options:
              -b4 allow smaller final blocks
              -b5 allow gaps within final blocks 
              -b2 less strict flanking positions 
              -b3 don't allow many contiguous nonconserved positions
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 
-bootstrap n    writes n bootstrap replicates of the input alignment to the output file 

           Sub-options for -concatenate 
           Use '-' as last argument to read alignment from standard input
-concatenate align1,...    name(s) of alignment files to add at the end of the input alignment
-by_rank      identify sequences by their rank in alignments (rather than by their name)
-record_partition record the locations of the concatenated pieces in the final concatenate
-output_format fmt    format of the concatenated alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the concatenated alignment (default is built from input filename)
-o -          write the concatenated alignment to standard output

           Sub-options for -align 
           Use '-' as last argument to read sequence file from standard input
-align_algo n  rank (in seaview from 0) of alignment algorithm, otherwise use seaview's default alignment algorithm
-align_extra_opts "option1 ..."  additional options to use when running the alignment algorithm
-align_at_protein_level  translate and align input sequences and reproduce alignment at DNA level.
-output_format fmt    format of the output alignment (mase, phylip, clustal, msf, fasta, or nexus)
-o fname      use fname as name of the output alignment (default is built from input filename)
-o -          write the output alignment to standard output

           Sub-options for -build_tree (either -distance or -parsimony is required)
           Use '-' as last argument to read alignment from standard input
-o fname      use fname as name of the output tree
-o -          write the output tree to standard output
-distance dist_name   computes the tree with a distance method using dist_name (observed, JC, K2P, logdet, Ka, Ks, Poisson or Kimura)
-distance_matrix fname  don't compute the tree, but write to fname the matrix of pairwise distances
-NJ           compute the distance tree by the Neighbor-Joining method (default is BioNJ)
-parsimony    compute the tree by the parsimony method 
-search more|less|one  controls how much rearrangement is done to find better trees (DNA parsimony only)
-nogaps       remove all gap-containing sites before computations
-replicates n use n bootstrap replicates to compute tree branch support
-jumbles n    jumble sequence order n times (parsimony only)
-gaps_as_unknown  encode gaps as unknown character state (parsimony only)
-sites selection_name    use the named selection of sites from the input alignment 
-species species_group_name    use the named group of species from the input alignment 

See http://doua.prabi.fr/software/seaview_data/seaview#Program%20arguments for more details
```

