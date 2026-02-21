# seq-gen CWL Generation Report

## seq-gen

### Tool Description
Sequence Generator - simulates the evolution of nucleotide or amino acid sequences along a phylogeny.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-gen:1.3.5--h7b50bb2_0
- **Homepage**: http://tree.bio.ed.ac.uk/software/Seq-Gen/
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-gen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq-gen/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2026-01-13
- **GitHub**: https://github.com/rambaut/Seq-Gen
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
Sequence Generator - seq-gen
Version 1.3.5
(c) Copyright, 1996-2025 Andrew Rambaut
Institute of Evolutionary Biology, University of Edinburgh

Originally developed at:
Department of Zoology, University of Oxford

Usage: seq-gen [-m MODEL] [-l #] [-n #] [-p #] [-s # | -d #] [-k #]
               [-c #1 #2 #3 | -a # [-g #]] [-i #] [-f e | #] [-t # | -r #]
               [-o[p|r|n|f][s]] [-w[a][r]]
               [-x NAME] [-y NAME] [-z #] [-q] [-h]
               [treefile]
  -l: # = sequence length [default = 1000].
  -n: # = simulated datasets per tree [default = 1].
  -p: # = number of partitions (and trees) per sequence [default = 1].
  -s: # = branch length scaling factor [default = 1.0].
  -d: # = total tree scale [default = use branch lengths].
  -k: # = use sequence k as ancestral (needs alignment) [default = random].

 Substitution model options:
  -m: MODEL = HKY, F84, GTR, JTT, WAG, PAM, BLOSUM, MTREV, CPREV45, MTART, LG, GENERAL
      HKY, F84 & GTR are for nucleotides the rest are for amino acids
  -a: # = shape (alpha) for gamma rate heterogeneity [default = none].
  -a: #1 #2 #3 = shape (alpha) for gamma rate heterogeneity for each codon position [default = none].
  -g: # = number of gamma rate categories [default = continuous].
  -i: # = proportion of invariable sites [default = 0.0].

 Nucleotide model specific options:
  -c: #1 #2 #3 = rates for codon position heterogeneity [default = none].
  -t: # = transition-transversion ratio [default = equal rate].
  -t: #1 #2 #3 = transition-transversion ratio for each codon position [default = equal rate].
  -r: #1 #2 #3 #4 #5 #6= general rate matrix [default = all 1.0].
  -f: #A #C #G #T = nucleotide frequencies [default = all equal].

 Amino Acid model specific options:
      specify using the order ARNDCQEGHILKMFPSTWYV
  -r: #1 .. #190 = general rate matrix [default = all 1.0].
  -f: #1 .. #20 = amino acid frequencies e=equal [default = matrix freqs].

 Output options:
  -o: Output file format [default = PHYLIP]
    p PHYLIP format
    r relaxed PHYLIP format
    n NEXUS format
    f FASTA format
    s Separate files for each dataset
  -w: Write additional information [default = none]
    a Write ancestral sequences for each node
    r Write rate for each site
  -x: NAME = a text file to insert after every dataset [default = none].
  -y: NAME = name of output file [default = to stdout, required for FASTA].

 Miscellaneous options:
  -z: # = seed for random number generator [default = system generated].
  -h: Give this help message
  -q: Quiet
  treefile: name of tree file [default = trees on stdin]
```


## Metadata
- **Skill**: not generated
