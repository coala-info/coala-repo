# sumaclust CWL Generation Report

## sumaclust

### Tool Description
star clustering of sequences.

### Metadata
- **Docker Image**: biocontainers/sumaclust:v1.0.31-2-deb_cv1
- **Homepage**: https://git.metabarcoding.org/obitools/sumaclust/wikis/home
- **Package**: https://anaconda.org/channels/bioconda/packages/sumaclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sumaclust/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
------------------------------------------------------------
 SUMACLUST Version 1.0.31
------------------------------------------------------------
 Synopsis : star clustering of sequences.
 Usage: sumaclust [options] <dataset>
------------------------------------------------------------
 Options:
 -h       : [H]elp - print <this> help

 -l       : Reference sequence length is the shortest. 

 -L       : Reference sequence length is the largest. 

 -a       : Reference sequence length is the alignment length (default). 

 -n       : Score is normalized by reference sequence length (default).

 -r       : Raw score, not normalized. 

 -d       : Score is expressed in distance (default : score is expressed in similarity). 

 -t ##.## : Score threshold for clustering. If the score is normalized and expressed in similarity (default),
            it is an identity, e.g. 0.95 for an identity of 95%. If the score is normalized
            and expressed in distance, it is (1.0 - identity), e.g. 0.05 for an identity of 95%.
            If the score is not normalized and expressed in similarity, it is the length of the
            Longest Common Subsequence. If the score is not normalized and expressed in distance,
            it is (reference length - LCS length).
            Only sequences with a similarity above ##.## with the center sequence of a cluster
            are assigned to that cluster. Default: 0.97.

 -e       : Exact option : A sequence is assigned to the cluster with the center sequence presenting the
            highest similarity score > threshold, as opposed to the default 'fast' option where a sequence is
            assigned to the first cluster found with a center sequence presenting a score > threshold.

 -R ##    : Maximum ratio between the counts of two sequences so that the less abundant one can be considered
            as a variant of the more abundant one. Default: 1.0.

 -p ##    : Multithreading with ## threads using openMP.

 -s ####  : Sorting by ####. Must be 'None' for no sorting, or a key in the fasta header of each sequence,
            except for the count that can be computed (default : sorting by count).

 -o       : Sorting is in ascending order (default : descending).

 -g       : n's are replaced with a's (default: sequences with n's are discarded).

 -B ###   : Output of the OTU table in BIOM format is activated, and written to file ###.

 -O ###   : Output of the OTU map (observation map) is activated, and written to file ###.

 -F ###   : Output in FASTA format is written to file ### instead of standard output.

 -f       : Output in FASTA format is deactivated.

------------------------------------------------------------
 Argument : the nucleotide dataset to cluster (or nothing   
            if the standard input should be used).          
------------------------------------------------------------
 http://metabarcoding.org/sumaclust
------------------------------------------------------------
```


## Metadata
- **Skill**: generated
