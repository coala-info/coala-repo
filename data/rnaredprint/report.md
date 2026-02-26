# rnaredprint CWL Generation Report

## rnaredprint_RNARedPrint

### Tool Description
Generates valid designs for the RNA secondary structures from the weighted distribution

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
- **Homepage**: https://github.com/yannponty/RNARedPrint
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaredprint/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnaredprint/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-10-02
- **GitHub**: https://github.com/yannponty/RNARedPrint
- **Stars**: N/A
### Original Help Text
```text
Error: Missing target structure(s).
Usage: /usr/local/bin/../share/RNARedPrint/RNARedPrint Struct1 Struct2 ... [--num k]
Generates valid designs for the RNA secondary structures from the weighted distribution
------ Mode ------------
  --num k           - Sets number of generated sequences (default 10)
  --count           - Simply compute the partition function and report the result.
------ Options ------------
  --weights w1,w2.. - Assigns custom weights to each targeted structure (default 1. for all)
  --gcw w       - Assigns custom weight to each occurrence of GC, to control GC% (default 1.)
  --model m         - Set energy model used for stochastic sampling: 
        m = 0: Uniform
        m = 1: Nussinov (-3/-2/-1 for GC/AU/GU)
        m = 2: Base pair energy model (Default; distinguishs GC/AU/GU, inner/exterior)
        m = 3: Stacking model (no isolated base-pairs!)
  --prefix            - Prefix path for locating the TD libraries
  --version            - Show version and exit
  --help            - Display help message and exit
```


## rnaredprint_design-energyshift.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
- **Homepage**: https://github.com/yannponty/RNARedPrint
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaredprint/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/design-energyshift.py", line 11, in <module>
    import RNA # ViennaRNA python bindings
    ^^^^^^^^^^
ModuleNotFoundError: No module named 'RNA'
```


## rnaredprint_design-multistate.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
- **Homepage**: https://github.com/yannponty/RNARedPrint
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaredprint/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/design-multistate.py", line 13, in <module>
    import RNA # ViennaRNA python bindings
    ^^^^^^^^^^
ModuleNotFoundError: No module named 'RNA'
```

