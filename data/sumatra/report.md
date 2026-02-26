# sumatra CWL Generation Report

## sumatra

### Tool Description
Computes all the pairwise LCS (Longest Common Subsequence) scores of one nucleotide dataset or between two nucleotide datasets.

### Metadata
- **Docker Image**: biocontainers/sumatra:v1.0.31-2-deb_cv1
- **Homepage**: https://github.com/sumatrapdfreader/sumatrapdf
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sumatra/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/sumatrapdfreader/sumatrapdf
- **Stars**: N/A
### Original Help Text
```text
-----------------------------------------------------------------------------------------------------------------------------
 SUMATRA Version 1.0.31
-----------------------------------------------------------------------------------------------------------------------------
 Synopsis : sumatra computes all the pairwise LCS (Longest Common Subsequence) scores
 of one nucleotide dataset or between two nucleotide datasets.
 Usage: sumatra [options] <dataset1> [dataset2]
-----------------------------------------------------------------------------------------------------------------------------
 Options:

 -h       : [H]elp - print <this> help

 -l       : Reference sequence length is the shortest. 

 -L       : Reference sequence length is the largest. 

 -a       : Reference sequence length is the alignment length (default). 

 -n       : Score is normalized by reference sequence length (default).

 -r       : Raw score, not normalized. 

 -d       : Score is expressed in distance (default: score is expressed in similarity). 

 -t ##.## : Score threshold. If the score is normalized and expressed in similarity (default),
            it is an identity, e.g. 0.95 for an identity of 95%. If the score is normalized
            and expressed in distance, it is (1.0 - identity), e.g. 0.05 for an identity of 95%.
            If the score is not normalized and expressed in similarity, it is the length of the
            Longest Common Subsequence. If the score is not normalized and expressed in distance,
            it is (reference length - LCS length).
            Only sequence pairs with a similarity above ##.## are printed. Default: 0.00 
            (no threshold).

 -p ##    : Number of threads used for computation (default=1).

 -g       : n's are replaced with a's (default: sequences with n's are discarded).
 -x       : Adds four extra columns with the count and length of both sequences.
-----------------------------------------------------------------------------------------------------------------------------
 First argument  : the nucleotide dataset to analyze (or nothing   
                   if there is only one dataset and the standard   
                   input should be used).                        

 Second argument : optionally the second nucleotide dataset
-----------------------------------------------------------------------------------------------------------------------------
 Results table description : 
 column 1 : Identifier sequence 1
 column 2 : Identifier sequence 2
 column 3 : Score
 column 4 : Count of sequence 1  (only with option -x)
 column 5 : Count of sequence 2  (only with option -x)
 column 6 : Length of sequence 1 (only with option -x)
 column 7 : Length of sequence 2 (only with option -x)
-----------------------------------------------------------------------------------------------------------------------------
 http://metabarcoding.org/sumatra
-----------------------------------------------------------------------------------------------------------------------------
```


## Metadata
- **Skill**: generated
