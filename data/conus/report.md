# conus CWL Generation Report

## conus

### Tool Description
FAIL to generate CWL: conus not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: conus not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: conus not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## conus_conus_train

### Tool Description
Single Sequence SCFG algorithms for training models

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
CONUS: Single Sequence SCFG algorithms
         CONUS 1.0 (in progress)
Usage: conus_train [-options] <training set files> 

where options are:
-h            : print short help, usage info, and grammar description
-g <string>   : Use grammar <string>, defaults to NUS
-l <file>     : Load prior specified in <file> 
-1            : Turn off the standard plus one prior 
-s <file>     : save model file to <file>; defaults to conus.mod 
-x            : print out parameters of model 
-t            : print traceback
-d            : debugging output 
-v            : verbose output 

Grammars available in CONUS: (use three letter codes) 
  code	Grammar:
  ----  -------- 
  NUS   Ambiguous Simple Grammar (G1) 
  UNA   Another Unambiguous (G3) 
  RUN   Little Unambiguous (G4) 
  IVO	Simplest Unambiguous (G5) 
  BJK	Pfold grammar (G6) 
  YRN	Stacking grammar (G2) 
  UYN   Stacking analog of UNA (G7)
  RY3   Stacking analog of RUN (G8)
  BK2	Stacking parameterization of BJK (G6S)

Usage: conus_train [-options] <training set files>
```

## conus_conus_fold

### Tool Description
Single Sequence SCFG algorithms for RNA structure prediction

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
CONUS: Single Sequence SCFG algorithms
         CONUS 1.0 (in progress)
Usage: conus_fold [-options] <seqfile in>

where options are:
-h            : print short help, usage info, and grammar description
-m <file>     : Use model <file> 
-g <string>   : Use grammar <string> and plus one scoring 
   -H	        (with -g) shift to hydrogen bonding scoring  
   --flat       (with -g) flat scoring scheme 
-o <file>     : redirect structure output to <file>
-v            : verbose output 
-x            : print out parameters of model 
-d            : debugging output 
-t            : debugging, print traceback
-f            : debugging, print fill matrix from cyk 
-q            : print predicted structures in stockholm format 
-c            : print ct output format for predicted structure


Grammars available in CONUS: (use three letter codes) 
  code	Grammar:
  ----  -------- 
  NUS   Ambiguous Simple Grammar (G1) 
  UNA   Another Unambiguous (G3) 
  RUN   Little Unambiguous (G4) 
  IVO	Simplest Unambiguous (G5) 
  BJK	Pfold grammar (G6) 
  YRN	Stacking grammar (G2) 
  UYN   Stacking analog of UNA (G7)
  RY3   Stacking analog of RUN (G8)
  BK2	Stacking parameterization of BJK (G6S)

Usage: conus_fold [-options] <seqfile in>
```

## conus_conus_compare

### Tool Description
Single Sequence SCFG algorithms for comparing test files.

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
CONUS: Single Sequence SCFG algorithms
         CONUS 1.0 (in progress)
Usage: conus_compare [-options] <testfile1> <testfile2> ...

where options are:
-h            : print short help, usage info, and grammar description
-m <file>     : Use model <file> 
-g <string>   : Use grammar <string> and plus one scoring 
   -H	        (with -g) shift to hydrogen bonding scoring  
   --flat       (with -g) flat scoring scheme 
-M	      : Use the Mathews99 method of evalutation 
-c            : output in table format 
-a            : give cummulative statistics (global) 
-i            : give statistics on each sequence (ignored in table mode)
-p            : output real and predicted structures
-q            : output predicted structures in stockholm format 
-v            : verbose output 
-x            : print out parameters of model 
-d            : debugging output 
-t            : debugging, print traceback
-f            : debugging, print fill matrix from cyk 

Grammars available in CONUS: (use three letter codes) 
  code	Grammar:
  ----  -------- 
  NUS   Ambiguous Simple Grammar (G1) 
  UNA   Another Unambiguous (G3) 
  RUN   Little Unambiguous (G4) 
  IVO	Simplest Unambiguous (G5) 
  BJK	Pfold grammar (G6) 
  YRN	Stacking grammar (G2) 
  UYN   Stacking analog of UNA (G7)
  RY3   Stacking analog of RUN (G8)
  BK2	Stacking parameterization of BJK (G6S)

Usage: conus_compare [-options] <testfile1> <testfile2> ...
```

## conus_ambtest

### Tool Description
Test ambiguity in sequence models using a model file and sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: ambtest -m model [-options] <seqfile in>

where options are:
-h            : print short help, usage info, and grammar description
-m <file>     : (req) Use model <file> 
-v            : verbose output 
-i            : ignore given structure -- use CYK calculated structure 
-d            : debugging output 
-x            : print out parameters of model 
-t            : debugging, print traceback
-c            : debugging, print CT format of structure 
-f            : debugging, print fill matrix from cyk
```

## conus_reorder

### Tool Description
Reorder suboptimals for a sequence file using specified grammar or model parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: reorder -b # [-options] <seqfile in>

where options are:
-b	      : (req) number of suboptimals to reorder 
-h            : print short help, usage info, and grammar description
-m <file>     : Use parameters, grammar and scoring specified in model <file> 
-g <string>   : Use grammar <string>, defaults to NUS; ignored if model file specified 
-x            : print out parameters of model 
-t            : print all parse trees (lots!) 
-a 	      : report all suboptimals table 
-c	      : report on things better than CYK 
-i	      : report tracebacks in CYK report (ignored if not with -c) 
-d            : debugging output 
-v            : verbose output 
-f            : debugging, print fill matrix from cyk 
-p            : print real with predicted structure
-q            : print predicted structures in stockholm format
```

## conus_weedamb

### Tool Description
Identify and optionally save ambiguous sequences from a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: weedamb <seqfile in>

where options are:
-h            : print short help and usage info 
-s <filename> : save ambiguous sequences to this file
```

## conus_stk2ct

### Tool Description
A tool to process sequence files, likely converting or extracting vector information from sequence alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/conus:1.0--h7b50bb2_6
- **Homepage**: http://eddylab.org/software/conus/
- **Package**: https://anaconda.org/channels/bioconda/packages/conus/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

FATAL: Incorrect number of command line arguments.
Usage: givect [-options] <seqfile in>
```

