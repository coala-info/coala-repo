# backspinpy CWL Generation Report

## backspinpy_backspin

### Tool Description
backSPIN commandline tool

### Metadata
- **Docker Image**: quay.io/biocontainers/backspinpy:0.2.1--pyh24bf2e0_1
- **Homepage**: https://github.com/linnarsson-lab/BackSPIN
- **Package**: https://anaconda.org/channels/bioconda/packages/backspinpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/backspinpy/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linnarsson-lab/BackSPIN
- **Stars**: N/A
### Original Help Text
```text
backSPIN commandline tool
       -------------------------

       The options are as follows:

       -i [inputfile]
       --input=[inputfile]
              Path of the cef formatted tab delimited file.
              Rows should be genes and columns single cells/samples.
              For further information on the cef format visit:
              https://github.com/linnarsson-lab/ceftools

       -o [outputfile]
       --output=[outputfile]
              The name of the file to which the output will be written

       -d [int]
              Depth/Number of levels: The number of nested splits that will be tried by the algorithm
       -t [int]
              Number of the iterations used in the preparatory SPIN.
              Defaults to 10
       -f [int]   
              Feature selection is performed before BackSPIN. Argument controls how many genes are seleceted.
              Selection is based on expected noise (a curve fit to the CV-vs-mean plot).
       -s [float]
              Controls the decrease rate of the width parameter used in the preparatory SPIN.
              Smaller values will increase the number of SPIN iterations and result in higher 
              precision in the first step but longer execution time.
              Defaults to 0.1
       -T [int]
              Number of the iterations used for every width parameter.
              Does not apply on the first run (use -t instead)
              Defaults to 8
       -S [float]
              Controls the decrease rate of the width parameter.
              Smaller values will increase the number of SPIN iterations and result in higher 
              precision but longer execution time.
              Does not apply on the first run (use -s instead)
              Defaults to 0.3
       -g [int]
              Minimal number of genes that a group must contain for splitting to be allowed.
              Defaults to 2
       -c [int]
              Minimal number of cells that a group must contain for splitting to be allowed.
              Defaults to 2
       -k [float]
              Minimum score that a breaking point has to reach to be suitable for splitting.
              Defaults to 1.15
       -r [float]
              If the difference between the average expression of two groups is lower than threshold the algorythm 
              uses higly correlated genes to assign the gene to one of the two groups
              Defaults to 0.2
       -b [axisvalue]
              Run normal SPIN instead of backSPIN.
              Normal spin accepts the parameters -T -S
              An axis value 0 to only sort genes (rows), 1 to only sort cells (columns) or 'both' for both
              must be passed
       -v  
              Verbose. Print  to the stdoutput extra details of what is happening
```

