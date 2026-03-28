# mauve CWL Generation Report

## mauve_progressiveMauve

### Tool Description
Aligns multiple sequences to find conserved regions and rearrangements.

### Metadata
- **Docker Image**: quay.io/biocontainers/mauve:2.4.0.snapshot_2015_02_13--h2688d6d_0
- **Homepage**: http://darlinglab.org/mauve/
- **Package**: https://anaconda.org/channels/bioconda/packages/mauve/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mauve/overview
- **Total Downloads**: 19.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
progressiveMauve usage:

When each genome resides in a separate file:
progressiveMauve [options] <seq1 filename> ... <seqN filename>

When all genomes are in a single file:
progressiveMauve [options] <seq filename>

Options:
	--island-gap-size=<number> Alignment gaps above this size in nucleotides are considered to be islands [20]
	--profile=<file> (Not yet implemented) Read an existing sequence alignment in XMFA format and align it to other sequences or alignments
	--apply-backbone=<file> Read an existing sequence alignment in XMFA format and apply backbone statistics to it
	--disable-backbone Disable backbone detection
	--mums Find MUMs only, do not attempt to determine locally collinear blocks (LCBs)
	--seed-weight=<number> Use the specified seed weight for calculating initial anchors
	--output=<file> Output file name.  Prints to screen by default
	--backbone-output=<file> Backbone output file name (optional).
	--match-input=<file> Use specified match file instead of searching for matches
	--max-gapped-aligner-length=<number> Maximum number of base pairs to attempt aligning with the gapped aligner
	--input-guide-tree=<file> A phylogenetic guide tree in NEWICK format that describes the order in which sequences will be aligned
	--output-guide-tree=<file> Write out the guide tree used for alignment to a file
	--version Display software version information
	--debug Run in debug mode (perform internal consistency checks--very slow)
	--scratch-path-1=<path> Designate a path that can be used for temporary data storage.  Two or more paths should be specified.
	--scratch-path-2=<path> Designate a path that can be used for temporary data storage.  Two or more paths should be specified.
	--collinear Assume that input sequences are collinear--they have no rearrangements
	--scoring-scheme=<ancestral|sp_ancestral|sp> Selects the anchoring score function.  Default is extant sum-of-pairs (sp).
	--no-weight-scaling Don't scale LCB weights by conservation distance and breakpoint distance
	--max-breakpoint-distance-scale=<number [0,1]> Set the maximum weight scaling by breakpoint distance.  Defaults to 0.5
	--conservation-distance-scale=<number [0,1]> Scale conservation distances by this amount.  Defaults to 0.5
	--muscle-args=<arguments in quotes> Additional command-line options for MUSCLE.  Any quotes should be escaped with a backslash
	--skip-refinement Do not perform iterative refinement
	--skip-gapped-alignment Do not perform gapped alignment
	--bp-dist-estimate-min-score=<number> Minimum LCB score for estimating pairwise breakpoint distance
	--mem-clean Set this to true when debugging memory allocations
	--gap-open=<number> Gap open penalty
	--repeat-penalty=<negative|zero> Sets whether the repeat scores go negative or go to zero for highly repetitive sequences.  Default is negative.
	--gap-extend=<number> Gap extend penalty
	--substitution-matrix=<file> Nucleotide substitution matrix in NCBI format
	--weight=<number> Minimum pairwise LCB score
	--min-scaled-penalty=<number> Minimum breakpoint penalty after scaling the penalty by expected divergence
	--hmm-p-go-homologous=<number> Probability of transitioning from the unrelated to the homologous state [0.00001]
	--hmm-p-go-unrelated=<number> Probability of transitioning from the homologous to the unrelated state [0.000000001]
	--hmm-identity=<number> Expected level of sequence identity among pairs of sequences, ranging between 0 and 1 [0.7]
	--seed-family Use a family of spaced seeds to improve sensitivity
	--solid-seeds Use solid seeds. Do not permit substitutions in anchor matches.
	--coding-seeds Use coding pattern seeds. Useful to generate matches coding regions with 3rd codon position degeneracy.
	--disable-cache Disable recursive anchor search cacheing to workaround a crash bug
	--no-recursion Disable recursive anchor search


Examples:
progressiveMauve --output=my_seqs.xmfa my_genome1.gbk my_genome2.gbk my_genome3.fasta

If genomes are in a single file and have no rearrangement:
progressiveMauve --collinear --output=my_seqs.xmfa my_genomes.fasta
```


## mauve_mauveAligner

### Tool Description
Aligns sequences using Mauve.

### Metadata
- **Docker Image**: quay.io/biocontainers/mauve:2.4.0.snapshot_2015_02_13--h2688d6d_0
- **Homepage**: http://darlinglab.org/mauve/
- **Package**: https://anaconda.org/channels/bioconda/packages/mauve/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
mauveAligner [options] <seq1 filename> <sml1 filename> ...  <seqN filename> <smlN filename>
Options:
	    --output=<file> Output file name.  Prints to screen by default
	    --mums Find MUMs only, do not attempt to determine locally collinear blocks (LCBs)
	    --no-recursion Don't perform recursive anchor identification (implies --no-gapped-alignment)
	    --no-lcb-extension If determining LCBs, don't attempt to extend the LCBs
	    --seed-size=<number> Initial seed match size, default is log_2( average seq. length )
	    --max-extension-iterations=<number> Limit LCB extensions to this number of attempts, default is 4
	    --eliminate-inclusions Eliminate linked inclusions in subset matches.
	    --weight=<number> Minimum LCB weight in base pairs per sequence
	    --match-input=<file> Use specified match file instead of searching for matches
	    --lcb-match-input  Indicates that the match input file contains matches that have been clustered into LCBs
	    --lcb-input=<file> Use specified lcb file instead of constructing LCBs (skips LCB generation)
	    --scratch-path=<path>  For large genomes, use a directory for storage of temporary data.  Should be given two or more times to with different paths.
	    --id-matrix=<file> Generate LCB stats and write them to the specified file
	    --island-size=<number> Find islands larger than the given number
	    --island-output=<file> Output islands the given file (requires --island-size)
	    --backbone-size=<number> Find stretches of backbone longer than the given number of b.p.
	    --max-backbone-gap=<number> Allow backbone to be interrupted by gaps up to this length in b.p.
	    --backbone-output=<file> Output islands the given file (requires --island-size)
	    --coverage-output=<file> Output a coverage list to the specified file (- for stdout)
	    --repeats Generates a repeat map.  Only one sequence can be specified
	    --output-guide-tree=<file> Write out a guide tree to the designated file
	    --collinear Assume that input sequences are collinear--they have no rearrangements

Gapped alignment controls:
	    --no-gapped-alignment Don't perform a gapped alignment
	    --max-gapped-aligner-length=<number> Maximum number of base pairs to attempt aligning with the gapped aligner
	    --min-recursive-gap-length=<number> Minimum size of gaps that Mauve will perform recursive MUM anchoring on (Default is 200)

Signed permutation matrix options:
	    --permutation-matrix-output=<file> Write out the LCBs as a signed permutation matrix to the given file
	    --permutation-matrix-min-weight=<number> A permutation matrix will be written for every set of LCBs with weight between this value and the value of --weight

Alignment output options:
	    --alignment-output-dir=<directory> Outputs a set of alignment files (one per LCB) to a given directory
	    --alignment-output-format=<directory> Selects the output format for --alignment-output-dir
	    --output-alignment=<file> Write out an XMFA format alignment to the designated file

Supported alignment output formats are: phylip, clustal, msf, nexus, mega, codon
```


## Metadata
- **Skill**: not generated
