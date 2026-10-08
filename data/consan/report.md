# consan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| consan_bstats | Failed | tool bug: the bootstrap sensitivity mean is sometimes huge garbage (e.g. 7e33) because bstat.c zeroes element [r] instead of [i], leaving the sum unset; PPV and alignment values are correct. |
| consan_comppair | PASS | Compared 4 Rfam tRNA pairs from the Consan R100 set with their scompare predictions: 154/168 trusted pairs found (91.7% sensitivity) and 98% alignment identity. |
| consan_pModel | PASS | Printed the transition and background parameters of the mix80 model from the Consan source; each transition row sums to 1. |
| consan_scompare | PASS | Correct stem-loop predicted in full mode (-f) with the mix80 model; the default pin mode segfaults because the image lacks the DART dpswalign helper, and the -s file stays empty because v1.2 never writes it. |
| consan_sfold | PASS | Correct stem-loop predicted in full mode (-f) with the mix80 model; the default pin mode segfaults because the image lacks the DART dpswalign helper. |
| consan_strain_ml | PASS | Trained a model on the Rfam v7 set that sfold then uses correctly; strain_ml exits 1 on success, so the CWL accepts exit codes 0 and 1. |

## consan_bstats

### Tool Description
Bootstrap summary statistics (sensitivity, PPV, alignment accuracy) from a table of per-pair comparison results.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: PASS

### Original Help Text
```text
FATAL: Usage: bstrap <file>
   where options are:
  -h            : get help 
  -v            : verbose 
  -i <int>      : Sampling iterations (100) 
  -d <file>     : Output diff data to <file>
  
```


## consan_comppair

### Tool Description
Compare a test pairwise structural alignment with a trusted one and report alignment accuracy and base-pair sensitivity and PPV.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: PASS

### Original Help Text
```text
Sankoff: Full Implementation of Sankoff 1985
         Sankoff 0.1 (in progress)Usage: comppair [-options] <seqfile in>

where options are:
-h            : print short help, usage info, and grammar description
-S	      : suppress comparison totals 
-q	      : suppress every pair alignment prediction output 
-M 1	      : turn on Mathews definition of paired 

Usage: comppair [-options] <seqfile in>
```


## consan_pModel

### Tool Description
Print the parameters of a Consan model file as probabilities and/or scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: PASS

### Original Help Text
```text
Sankoff: Full Implementation of Sankoff 1985
         Sankoff 0.1 (in progress)Usage: pModel [-options] <modfile>

  [Defaults to printing all parameters as probs] 

where options are:
-h            : print short help, usage info, and grammar description
-t            : Print transition parameters 
-x            : Print 16x16 pairwise emission parameters 
-f            : Print 4x4 alignment emission parameters 
-d            : Print 4 background (to gap) parameters 
-q            : Print parameters as scores (defaults to as probs) 
-S            : Print parameters as both probs and scores 
-l	      : Linearize output for gnuplot (not valid with -q or -S) 
-v	      : Include labels in linear output 

Usage: pModel [-options] <modfile>
```


## Metadata
- **Skill**: generated

## consan_strain_ml

### Tool Description
Train models for consan_strain using training set files.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: mltrain [-options] <training set files> 

where options are:
-h            : print short help, usage info, and grammar description
-g <string>   : Use grammar <string>, defaults to STA
-s <file>     : save model file to <file>
-x            : print out parameters of model 
-q            : print out counts used for model 
-t            : print traceback
-d            : debugging output 
-v            : verbose output 
-n	      : Turn off weighting scheme
-c	      : Force recalculate weights (defaults to given when available)
-V	      : Use Voronoi weights instead of GSC 
-T <int>      : Setup Tying Type 
  	        [No tying = 0; NT counts = 1; Gap Open/Extend counts = 2; 
  		 Gap Open/Extend probs = 3; LR Symmetry 4 (default)]
```

## consan_sfold

### Tool Description
Structural folding and alignment tool for sequences using parameters, grammar, and scoring models.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: sfold [-options] <seqfile1> <seqfile2>

where options are:
-h            : print short help, usage info, and grammar description
-m <file>     : Use parameters, grammar and scoring specified in model <file> 
-M <int>      : Ensure that pin selection results in something near X Mbytes memory 
-C <int>      : use <int> pins from trusted alignment 
-P <int>      : use <int> predicted pins 
-V	      : output as single sequences rather than pair 
-f 	      : execute full (unconstrained) algorithm 
-x            : print out parameters of model 
-t            : print traceback
-d            : debugging output 
-v            : verbose output 
-f            : debugging, print fill matrix from cyk
```

## consan_scompare

### Tool Description
Given a MSA, calculate foldings for all pairs. Output two files -- predicted pairs to stdout and given pairs to a required -s file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: scompare [-options] <test msa> 

[Given a MSA, calculate foldings for all pairs.  Output two files -- 
predicted pairs to stdout and given pairs to a required -s file.] 
where options are:
-h            : print short help, usage info, and grammar description
-s <file>     : Output of given structure in ordered pairs (needed for comppair) 
-M <int>      : Ensure that pin selection results in something near X Mbytes memory 
-C <int>      : do CYK and use <int> pins from trusted alignment 
-P <int>      : do CYK and use <int> predicted pins )
-f 	      : do full sankoff (no constraints) 
-t            : print traceback
-d            : debugging output 
-v            : verbose output 
-S            : suppress extra output
```

