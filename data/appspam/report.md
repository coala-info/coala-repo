# appspam CWL Generation Report

## appspam

### Tool Description
Alignment-free phylogenetic placement algorithm based on spaced word matches

### Metadata
- **Docker Image**: quay.io/biocontainers/appspam:1.03--h9f5acd7_3
- **Homepage**: https://github.com/matthiasblanke/App-SpaM/
- **Package**: https://anaconda.org/channels/bioconda/packages/appspam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/appspam/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/matthiasblanke/App-SpaM
- **Stars**: N/A
### Original Help Text
```text
------------------------------------------------
 Alignment-free phylogenetic placement algorithm
           based on spaced word matches         
------------------------------------------------


Execute appspam with:
	./appspam -s <references> -t <tree> -q <queries> [optional parameters]
------------------------------------------------------------
A typical call might look like:
	./appspam -h
	./appspam -s references.fasta -q query.fasta -t tree.nwk
	./appspam -s references.fasta -q query.fasta -t tree.nwk -d 10 -w 8

The following parameters are necessary:
    -s 	Reference sequences.
        Full path to fasta file with references.
    -q 	Query sequences.
        Full path to fasta file with query sequences.
    -t	Reference tree.
        File of reference tree in newick format.
        (Rooted, bifurcating tree in newick format.
        All leaves must have identical names to reference sequences.)

The following parameters are optional.
    -o  --out_jplace        Path and name to JPlace output file.

    -w  --weight            Weight of pattern.

    -d  --dontCare          Number of don't care positions.

    -m  --mode              Placement-mode.
                            One of [MINDIST, SPAMCOUNT, LCADIST, LCACOUNT, SPAMX]

    -x  --spamx             Threshold when to place at leaves for SPAMX.

    -u  --unassembled       Use unassembled references, 
                            see github repository for more information.

        --delimiter         Delimiter used for unassembled references.
		
    -p  --pattern           Number of patterns.

        --threads           Number of threads.

        --sampling          Experimental: Samples the spaced word matches.

    -b  --readBlockSize     Read block size.

        --threshold         Threshold used for filtering spaced word matches. 

Following additional flags exist:
    -h                      Print out help and exit.
    -v                      Turn on verbose mode with additional 
	                        information printed to std_out.
        --write-scores      Write all query-reference distances to files.
        --write-histogram   Write scores for all spaced word matches to file.
```


## Metadata
- **Skill**: generated
