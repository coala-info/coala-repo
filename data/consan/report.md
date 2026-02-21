# consan CWL Generation Report

## consan

### Tool Description
FAIL to generate CWL: consan not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/consan:1.2--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/consan/
- **Package**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/consan/overview
- **Total Downloads**: 71.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: consan not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: consan not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

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

