# gecko CWL Generation Report

## gecko_workflow.sh

### Tool Description
GECKO workflow for sequence comparison.

### Metadata
- **Docker Image**: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
- **Homepage**: https://github.com/otorreno/gecko
- **Package**: https://anaconda.org/channels/bioconda/packages/gecko/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gecko/overview
- **Total Downloads**: 17.8K
- **Last updated**: 2025-07-24
- **GitHub**: https://github.com/otorreno/gecko
- **Stars**: N/A
### Original Help Text
```text
==== GECKO HELP ...

   To run gecko, use:
   ./gecko/bin/workflow.sh query reference length similarity wordLength 1

   Query sequence: The sequence that will be compared against the reference. Use only FASTA format.
    Reference sequence: The reference sequence where to look for matches from the query. Note that the reverse strand is computed for the reference and also matched. Use only FASTA format.
   Length: This parameter is the minimum length in nucleotides for an HSP (similarity fragment) to be conserved. Any HSP below this length will be filtered out of the comparison. It is recommended to use around 40 bp for small organisms (e.g. bacterial mycoplasma or E. Coli) and around 100 bp or more for larger organisms (e.g. human chromosomes).
   Similarity: This parameter is analogous to the minimum length, however, instead of length, the similarity is used as threshold. The similarity is calculated as the score attained by an HSP divided by the maximum possible score. Use values above 50-60 to filter noise.
   Word length: This parameter is the seed size used to find HSPs. A smaller seed size will increase sensitivity and decrease performance, whereas a larger seed size will decrease sensitivity and increase performance. Recommended values are 12 or 16 for smaller organisms (bacteria) and 32 for larger organisms (chromosomes). These values must be multiples of 4.

 ====
```


## gecko_frags2align.sh

### Tool Description
Converts fragment files to alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
- **Homepage**: https://github.com/otorreno/gecko
- **Package**: https://anaconda.org/channels/bioconda/packages/gecko/overview
- **Validation**: PASS

### Original Help Text
```text
==== ERROR ... you called this script inappropriately.

   usage:  /usr/local/bin/frags2align.sh fragsFILE.frags/.csv fastaX fastaY alignments.txt
```


## Metadata
- **Skill**: generated
